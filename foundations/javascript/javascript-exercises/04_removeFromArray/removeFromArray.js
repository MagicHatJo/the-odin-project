const removeFromArray = function(array, ...elementsToRemove) {
	for (let i = 0; i < elementsToRemove.length; i++) {
		array = array.filter(function(a) { return a !== elementsToRemove[i]; });
	}
	return array;
}
// Do not edit below this line
module.exports = removeFromArray;
