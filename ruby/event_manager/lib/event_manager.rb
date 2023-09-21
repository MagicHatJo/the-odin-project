require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'date'

def clean_zipcode(zipcode)
	zipcode.to_s.rjust(5,"0")[0..4]
end

def clean_phone_number(phone_number)
	phone_number.gsub!(/\D/, "")
	return phone_number        if phone_number.length == 10
	return phone_number[0..10] if phone_number.length > 10 && phone_number[0] == "1"
	return "Invalid Number"
end

def clean_time(time)
	time = DateTime.strptime(time, "%m/%d/%y %H:%M")
	return time.hour
end

def clean_date(time)
	date = DateTime.strptime(time, "%m/%d/%y %H:%M")
	return [
		"Sunday",
		"Monday",
		"Tuesday",
		"Wednesday",
		"Thursday",
		"Friday",
		"Saturday"
	][Date.new(date.year, date.month, date.day).wday]
end

def legislators_by_zipcode(zip)
	civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
	civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

	begin
		civic_info.representative_info_by_address(
			address: zip,
			levels: 'country',
			roles: ['legislatorUpperBody', 'legislatorLowerBody']
		).officials
	rescue
		'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
	end
end

def save_thank_you_letter(id,form_letter)
	Dir.mkdir('output') unless Dir.exist?('output')
  
	filename = "output/thanks_#{id}.html"
  
	File.open(filename, 'w') do |file|
		file.puts form_letter
	end
end

puts 'EventManager initialized.'

contents = CSV.open(
	'event_attendees.csv',
	headers: true,
	header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template    = ERB.new template_letter
reg_time = Array.new(24, 0)
reg_day  = Hash.new(0)

contents.each do |row|
	id   = row[0]
	name = row[:first_name]
	zipcode     = clean_zipcode(row[:zipcode])
	homephone   = clean_phone_number(row[:homephone])
	legislators = legislators_by_zipcode(zipcode)
	form_letter = erb_template.result(binding)

	save_thank_you_letter(id,form_letter)

	reg_time[clean_time(row[:regdate])] += 1
	reg_day[clean_date(row[:regdate])]  += 1
end

puts "Registration times"
reg_time.each { |num| print "#{num.to_s.rjust(2, '0')} "}
puts ""
(0..23).each { |i| print "#{i.to_s.rjust(2, '0')} "}
puts ""

puts "Registration days of the week:"
reg_day.each do |day, count|
  puts "#{day}: #{count}"
end