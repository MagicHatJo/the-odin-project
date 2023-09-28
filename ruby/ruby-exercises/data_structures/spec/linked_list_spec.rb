require 'stringio'

require 'spec_helper'
require_relative '../linked_list'

def capture_stdout(function, *args)
	output = StringIO.new()
	original = $stdout
	$stdout = output
	function.call(*args)
	return output.string
ensure
	$stdout = original
end

RSpec.describe 'Linked List' do
	describe 'append' do

		it 'head' do
			list = LinkedList.new()
			list.append(42)
			check = list.head.data
			result = 42
			expect(check).to eq(result)
		end

		it 'multiple' do
			list = LinkedList.new()
			list.append(42)
			list.append(69)
			list.append(24)
			list.append(420)
			check = []
			curr = list.head
			until curr.nil? do
				check << curr.data
				curr = curr.next
			end
			result = [42, 69, 24, 420]
			expect(check).to eq(result)
			expect(list.tail.data).to eq(420)
		end
	end

	describe 'prepend' do

		it 'head' do
			list = LinkedList.new()
			list.prepend(42)
			check = list.head.data
			result = 42
			expect(check).to eq(result)
		end

		it 'multiple' do
			list = LinkedList.new()
			list.prepend(42)
			list.prepend(69)
			list.prepend(24)
			list.prepend(420)
			check = []
			curr = list.head
			until curr.nil? do
				check << curr.data
				curr = curr.next
			end
			result = [420, 24, 69, 42]
			expect(check).to eq(result)
			expect(list.tail.data).to eq(42)
		end
	end

	describe 'size' do

		it '0' do
			list = LinkedList.new()
			check = list.size
			result = 0
			expect(check).to eq(result)
		end

		it '5' do
			list = LinkedList.new()
			list.append(42)
			list.append(42)
			list.append(42)
			list.append(42)
			list.append(42)
			check = list.size
			result = 5
			expect(check).to eq(result)
		end
	end

	describe 'head' do

		it 'empty' do
			list = LinkedList.new()
			check = list.head
			result = nil
			expect(check).to eq(result)
		end

		it 'basic' do
			list = LinkedList.new()
			list.prepend(42)
			list.prepend(69)
			list.prepend(24)
			list.prepend(420)
			list.append(86)
			check = list.head.data
			result = 420
			expect(check).to eq(result)
		end
	end

	describe 'tail' do

		it 'empty' do
			list = LinkedList.new()
			check = list.tail
			result = nil
			expect(check).to eq(result)
		end

		it 'basic' do
			list = LinkedList.new()
			list.prepend(42)
			list.prepend(69)
			list.prepend(24)
			list.prepend(420)
			check = list.tail.data
			result = 42
			expect(check).to eq(result)
		end
	end

	describe 'at' do

		it 'empty' do
			list = LinkedList.new()
			check = list.at(5)
			result = nil
			expect(check).to eq(result)
		end

		it 'basic' do
			list = LinkedList.new()
			list.append(42)
			list.append(69)
			list.append(24)
			list.append(420)
			check = list.at(2)
			check = check.data unless check.nil?
			result = 24
			expect(check).to eq(result)
		end

		it 'first' do
			list = LinkedList.new()
			list.append(42)
			list.append(69)
			list.append(24)
			list.append(420)
			check = list.at(0)
			check = check.data unless check.nil?
			result = 42
			expect(check).to eq(result)
		end

		it 'out of bounds' do
			list = LinkedList.new()
			list.append(42)
			list.append(69)
			list.append(24)
			list.append(420)
			check = list.at(20)
			check = check.data unless check.nil?
			result = 420
			expect(check).to eq(result)
		end
	end

	describe 'pop' do

		it 'empty' do
			list = LinkedList.new()
			check = list.pop()
			result = nil
			expect(check).to eq(result)
		end

		it 'basic' do
			list = LinkedList.new()
			list.append(42)
			list.append(69)
			list.append(24)
			list.append(420)
			check = list.pop().data
			result = 420
			expect(check).to eq(result)
		end

		it 'one item' do
			list = LinkedList.new()
			list.append(42)
			check = [list.pop().data, list.head, list.tail]
			result = [42, nil, nil]
			expect(check).to eq(result)
		end
	end

	describe 'contains' do

		it 'empty' do
			list = LinkedList.new()
			check = list.contains?(42)
			result = false
			expect(check).to eq(result)
		end

		it 'basic' do
			list = LinkedList.new()
			list.append(42)
			list.append(69)
			list.append(24)
			list.append(420)
			check = list.contains?(24)
			result = true
			expect(check).to eq(result)
		end

		it 'not found' do
			list = LinkedList.new()
			list.append(42)
			list.append(69)
			list.append(24)
			list.append(420)
			check = list.contains?(80)
			result = false
			expect(check).to eq(result)
		end

		it 'one item' do
			list = LinkedList.new()
			list.append(42)
			check = list.contains?(42)
			result = true
			expect(check).to eq(result)
		end
	end

	describe 'find' do

		it 'empty' do
			list = LinkedList.new()
			check = list.find(42)
			result = nil
			expect(check).to eq(result)
		end

		it 'basic' do
			list = LinkedList.new()
			list.append(42)
			list.append(69)
			list.append(24)
			list.append(420)
			check = list.find(24)
			result = 2
			expect(check).to eq(result)
		end

		it 'not found' do
			list = LinkedList.new()
			list.append(42)
			list.append(69)
			list.append(24)
			list.append(420)
			check = list.find(80)
			result = nil
			expect(check).to eq(result)
		end

		it 'one item' do
			list = LinkedList.new()
			list.append(42)
			check = list.find(42)
			result = 0
			expect(check).to eq(result)
		end
	end

	describe 'to_s' do

		it 'single item' do
			list = LinkedList.new()
			list.append(42)
			
			check = capture_stdout(list.method(:to_s))
			result = "42 -> nil\n"
			expect(check).to eq(result)
		end

		it 'multiple' do
			list = LinkedList.new()
			list.append(42)
			list.append(69)
			list.append(24)
			list.append(420)
			
			check = capture_stdout(list.method(:to_s))
			result = "42 -> 69 -> 24 -> 420 -> nil\n"
			expect(check).to eq(result)
		end

		it 'empty list' do
			list = LinkedList.new()
			check = capture_stdout(list.method(:to_s))
			result = "nil\n"
			expect(check).to eq(result)
		end
	end

	describe 'insert_at' do

		it 'list middle' do
			list = LinkedList.new()
			list.append(42)
			list.append(69)
			list.append(24)
			list.append(420)
			list.insert_at(80, 3)
			check = capture_stdout(list.method(:to_s))
			result = "42 -> 69 -> 24 -> 80 -> 420 -> nil\n"
			expect(check).to eq(result)
		end

		it 'list start' do
			list = LinkedList.new()
			list.append(42)
			list.append(69)
			list.append(24)
			list.append(420)
			list.insert_at(80, 0)
			check = capture_stdout(list.method(:to_s))
			result = "80 -> 42 -> 69 -> 24 -> 420 -> nil\n"
			expect(check).to eq(result)
		end

		it 'list end' do
			list = LinkedList.new()
			list.append(42)
			list.append(69)
			list.append(24)
			list.append(420)
			list.insert_at(80, 4)
			check = capture_stdout(list.method(:to_s))
			result = "42 -> 69 -> 24 -> 420 -> 80 -> nil\n"
			expect(check).to eq(result)
		end

		it 'past length' do
			list = LinkedList.new()
			list.append(42)
			list.append(69)
			list.append(24)
			list.append(420)
			list.insert_at(80, 40)
			check = capture_stdout(list.method(:to_s))
			result = "42 -> 69 -> 24 -> 420 -> 80 -> nil\n"
			expect(check).to eq(result)
		end

		it 'empty list' do
			list = LinkedList.new()
			list.insert_at(80, 0)
			check = capture_stdout(list.method(:to_s))
			result = "80 -> nil\n"
			expect(check).to eq(result)
		end

		it 'negative' do
			list = LinkedList.new()
			list.append(42)
			list.append(69)
			list.append(24)
			list.append(420)
			list.insert_at(80, -8)
			check = capture_stdout(list.method(:to_s))
			result = "42 -> 69 -> 24 -> 420 -> nil\n"
			expect(check).to eq(result)
		end

		it 'size' do
			list = LinkedList.new()
			list.append(42)
			list.append(69)
			list.append(24)
			list.append(420)
			list.insert_at(80, 3)
			check = list.size
			result = 5
			expect(check).to eq(result)
		end
	end

	describe 'remove_at' do

		it 'list middle' do
			list = LinkedList.new()
			list.append(42)
			list.append(69)
			list.append(24)
			list.append(420)
			list.remove_at(2)
			check = capture_stdout(list.method(:to_s))
			result = "42 -> 69 -> 420 -> nil\n"
			expect(check).to eq(result)
		end

		it 'list start' do
			list = LinkedList.new()
			list.append(42)
			list.append(69)
			list.append(24)
			list.append(420)
			list.remove_at(0)
			check = capture_stdout(list.method(:to_s))
			result = "69 -> 24 -> 420 -> nil\n"
			expect(check).to eq(result)
		end

		it 'list end' do
			list = LinkedList.new()
			list.append(42)
			list.append(69)
			list.append(24)
			list.append(420)
			list.remove_at(3)
			check = capture_stdout(list.method(:to_s))
			result = "42 -> 69 -> 24 -> nil\n"
			expect(check).to eq(result)
		end

		it 'check tail' do
			list = LinkedList.new()
			list.append(42)
			list.append(69)
			list.append(24)
			list.append(420)
			list.remove_at(3)
			check = list.tail.data
			result = 24
			expect(check).to eq(result)
		end

		it 'past length' do
			list = LinkedList.new()
			list.append(42)
			list.append(69)
			list.append(24)
			list.append(420)
			list.remove_at(40)
			check = capture_stdout(list.method(:to_s))
			result = "42 -> 69 -> 24 -> 420 -> nil\n"
			expect(check).to eq(result)
		end

		it 'empty list' do
			list = LinkedList.new()
			list.remove_at(0)
			check = capture_stdout(list.method(:to_s))
			result = "nil\n"
			expect(check).to eq(result)
		end

		it 'negative' do
			list = LinkedList.new()
			list.append(42)
			list.append(69)
			list.append(24)
			list.append(420)
			list.remove_at(-8)
			check = capture_stdout(list.method(:to_s))
			result = "42 -> 69 -> 24 -> 420 -> nil\n"
			expect(check).to eq(result)
		end

		it 'size' do
			list = LinkedList.new()
			list.append(42)
			list.append(69)
			list.append(24)
			list.append(420)
			list.remove_at(2)
			list.remove_at(2)
			check = list.size
			result = 2
			expect(check).to eq(result)
		end
	end
end
