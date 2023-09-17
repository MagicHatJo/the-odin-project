const findTheOldest = function(people) {
	const getAge = (a) => (a.hasOwnProperty("yearOfDeath") ? a.yearOfDeath : new Date().getFullYear()) - a.yearOfBirth;
	return people.sort((a, b) => getAge(b) - getAge(a))[0];
};

// Do not edit below this line
module.exports = findTheOldest;
