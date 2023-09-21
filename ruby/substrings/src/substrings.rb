def substrings(sentence, dictionary)
	sentence = sentence.downcase
	dictionary.reduce(Hash.new(0)) do |out, word|
		count = sentence.scan(word).count
		out[word] = count if count > 0
		out
	end
end