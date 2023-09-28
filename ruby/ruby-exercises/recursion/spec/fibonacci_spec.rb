require 'spec_helper'
require_relative '../fibonacci'

RSpec.describe 'Fibonacci' do
	describe 'Iterative' do

		it 'basic test 01' do
			check = fibs(5)
			result = [0, 1, 1, 2, 3, 5]
			expect(check).to eq(result)
		end

		it 'basic test 02' do
			check = fibs(10)
			result = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
			expect(check).to eq(result)
		end

		it 'test 0' do
			check = fibs(0)
			result = [0]
			expect(check).to eq(result)
		end

		it 'test negative' do
			check = fibs(-5)
			result = [0]
			expect(check).to eq(result)
		end
	end

	describe 'Recursive' do

		it 'basic test 01' do
			check = fibs_rec(5)
			result = [0, 1, 1, 2, 3, 5]
			expect(check).to eq(result)
		end

		it 'basic test 02' do
			check = fibs_rec(10)
			result = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
			expect(check).to eq(result)
		end

		it 'test 0' do
			check = fibs_rec(0)
			result = [0]
			expect(check).to eq(result)
		end

		it 'test negative' do
			check = fibs_rec(-5)
			result = [0]
			expect(check).to eq(result)
		end
	end
end