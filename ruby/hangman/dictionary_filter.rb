

input_file_path  = 'google-10000-english-no-swears.txt'
output_file_path = 'minimum_5.txt'
minimum_word_length = 5

filtered_words = []
File.open(input_file_path, 'r') do |file|
	filtered_words = file.read().split("\n").select { |word| word.length >= minimum_word_length }
end

File.open(output_file_path, 'w') do |file|
	file.puts(filtered_words)
end