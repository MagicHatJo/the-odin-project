require 'spec_helper'
require_relative '../src/stock_picker'

RSpec.describe 'Stock Picker' do

	describe 'example' do

		it 'test_01' do
			expect(stock_picker([17,3,6,9,15,8,6,1,10])).to eq([1, 4])
		end

	end

	describe 'basic tests' do

		it 'increasing prices' do
			expect(stock_picker([1, 2, 3, 4, 5])).to eq([0, 4])
		end

		it 'decreasing prices' do
			expect(stock_picker([5, 4, 3, 2, 1])).to eq([0, 0])
		end

		it 'random' do
			expect(stock_picker([10, 5, 12, 8, 15, 7])).to eq([1, 4])
		end
	end

	describe 'edge cases' do

		it 'empty array' do
			expect(stock_picker([])).to eq(nil)
		end

		it 'identical prices' do
			expect(stock_picker([10, 10, 10, 10, 10, 10, 10])).to eq([0, 0])
		end
	end

end