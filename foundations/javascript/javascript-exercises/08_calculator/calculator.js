const add = function(a, b) {
	return a + b;
};

const subtract = function(a, b) {
	return a - b;
};

const sum = function(a) {
	return a.reduce((counter, current) => counter + current, 0);
};

const multiply = function(a) {
	return a.reduce((counter, current) => counter * current, 1);
};

const power = function(a, b) {
	return a ** b;
};

const factorial = function(a) {
	let out = 1;
	while (a > 0) {
		out *= a;
		a -= 1;
	}

	return out;
};

// Do not edit below this line
module.exports = {
	add,
	subtract,
	sum,
	multiply,
	power,
	factorial
};
