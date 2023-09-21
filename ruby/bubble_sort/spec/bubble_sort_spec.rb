require 'spec_helper'
require_relative '../src/bubble_sort'

RSpec.describe 'Bubble Sort' do

	describe 'example' do

		it 'test_01' do
			expect(bubble_sort([4,3,78,2,0,2])).to eq([0,2,2,3,4,78])
		end

		it 'test_02' do
			expect(bubble_sort([5, 1, 4, 2, 8])).to eq([1, 2, 4, 5, 8])
		end
		  
		it 'test_03' do
			expect(bubble_sort([6, 6, 6, 6])).to eq([6, 6, 6, 6])
		end

		it 'test_04' do
			expect(bubble_sort([1, 3, 5, 7, 9])).to eq([1, 3, 5, 7, 9])
		end
		
		it 'test_05' do
			expect(bubble_sort([9, 7, 5, 3, 1])).to eq([1, 3, 5, 7, 9])
		end
		
		it 'test_06' do
			expect(bubble_sort([100, 10, 1000, 1, 0, 0])).to eq([0, 0, 1, 10, 100, 1000])
		end
	end
end