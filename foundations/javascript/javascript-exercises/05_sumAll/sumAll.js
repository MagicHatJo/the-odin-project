const sumAll = function(start, end) {
	if (start < 0 || end < 0)
		return "ERROR";
	if (!(typeof start === "number" && typeof end === "number"))
		return "ERROR";

	if (start > end)
		[start, end] = [end, start]
	return ((end * (end + 1) / 2) - ((start- 1) * start / 2));
};

// Do not edit below this line
module.exports = sumAll;
