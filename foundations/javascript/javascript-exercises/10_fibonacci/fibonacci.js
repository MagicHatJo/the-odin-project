const fibonacci = function(num) {
	if (typeof(num) == String)
		num = parseInt(str);
	
	if (num < 0)
		return "OOPS";

	let prev = 0;
	let curr = 1;

	for (let i = 1; i < num; i++)
		[prev, curr] = [curr, prev + curr];

	return curr;
};

// Do not edit below this line
module.exports = fibonacci;
