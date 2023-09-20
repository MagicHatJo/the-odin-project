require 'spec_helper'
require_relative '../src/caesar_cipher'

RSpec.describe 'Caesar Cipher' do

  describe 'basic checks' do

    it 'rot13' do
      expect(caesar_cipher("hello caesar", 13)).to eq("uryyb pnrfne")
    end
	
	it 'rot5' do
		expect(caesar_cipher("Hello Caesar", 5)).to eq("Mjqqt Hfjxfw")
	end

	it 'rot24' do
		expect(caesar_cipher("Hello Caesar", 24)).to eq("Fcjjm Aycqyp")
	end

    it 'case sensitive' do
      expect(caesar_cipher("HelLo CAeSar", 13)).to eq("UryYb PNrFne")
    end
  end

  describe 'edge cases' do

    it 'rot0' do
		expect(caesar_cipher("Hello Caesar", 0)).to eq("Hello Caesar")
    end
	it 'rot26' do
		expect(caesar_cipher("Hello Caesar", 26)).to eq("Hello Caesar")
    end
	it 'overflow' do
		expect(caesar_cipher("Hello Caesar", 56)).to eq("Lipps Geiwev")
	end
	it 'underflow' do
		expect(caesar_cipher("Hello Caesar", -10)).to eq("Xubbe Squiqh")
	end
	it 'symbols' do
		expect(caesar_cipher("Hello, Caesar?!", 18)).to eq("Zwddg, Uswksj?!")
	end
  end
end