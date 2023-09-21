require 'spec_helper'
require_relative '../src/substrings'

RSpec.describe 'Substrings' do

	describe 'basic checks' do

		it 'example 1' do
			expect(substrings("below", ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]))
				.to eq({ "below" => 1, "low" => 1 })
		end

		it 'example 2' do
			expect(substrings("Howdy partner, sit down! How's it going?", ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]))
				.to eq({ "down" => 1, "go" => 1, "going" => 1, "how" => 2, "howdy" => 1, "it" => 2, "i" => 3, "own" => 1, "part" => 1, "partner" => 1, "sit" => 1 })
		end
		
		it 'repeat word' do
			expect(substrings("below below below", ["below", "low", "five"]))
				.to eq({ "below" => 3, "low" => 3 })
		end
	end
end