def caesar_cipher(sentence, shift)
	shift %= 26
	return sentence if shift == 0
	out = ('A'.ord + shift).chr + "-ZA-" + ('A'.ord + shift - 1).chr
	out += out.downcase
	sentence.tr("A-Za-z", out)
end