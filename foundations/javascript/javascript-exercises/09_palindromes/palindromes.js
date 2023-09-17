const palindromes = function (str) {
	str = str.toLowerCase().match(/[a-z0-9]/g).join('');
	return str === str.split('').reverse().join('');
};

// Do not edit below this line
module.exports = palindromes;