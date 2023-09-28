require 'spec_helper'
require_relative '../merge_sort'

RSpec.describe 'Merge Sort' do
	describe 'Recursive' do

		it 'empty list' do
			check = merge_sort([])
			result = []
			expect(check).to eq(result)
		end

		it 'already sorted' do
			check = merge_sort([1, 2, 3, 4, 5])
			result = [1, 2, 3, 4, 5]
			expect(check).to eq(result)
		end

		it 'reversed list' do
			check = merge_sort([5, 4, 3, 2, 1])
			result = [1, 2, 3, 4, 5]
			expect(check).to eq(result)
		end

		it 'eveen list' do
			check = merge_sort([7, 2, 5, 1, 8, 3, 6, 4])
			result = [1, 2, 3, 4, 5, 6, 7, 8]
			expect(check).to eq(result)
		end

		it 'odd list' do
			check = merge_sort([42, 12, 7, 31, 24, 18, 5, 9, 2])
			result = [2, 5, 7, 9, 12, 18, 24, 31, 42]
			expect(check).to eq(result)
		end

		it 'duplicate elements' do
			check = merge_sort([5, 2, 8, 2, 3, 1, 5, 4, 8, 1, 7, 6, 6, 3, 4, 7])
			result = [1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8]
			expect(check).to eq(result)
		end
	end
end