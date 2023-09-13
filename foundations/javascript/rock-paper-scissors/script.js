function randomChoice(array) {
	if (!Array.isArray(array) || array.length === 0)
		return undefined;
	return array[Math.floor(Math.random() * array.length)];
}

function getPlayerChoice(roundNumber) {
	const valid = new Set(["rock", "paper", "scissors"]);
	let playerInput;
	do {
		playerInput = prompt("Rock, Paper, Scissors\nRound " + (roundNumber).toString()).toLowerCase();
	} while (!valid.has(playerInput));
	return playerInput
}

function getComputerChoice() {
	return randomChoice(["rock", "paper", "scissors"]);
}

function playRound(playerSelection, computerSelection) {
	playerSelection = playerSelection.toLowerCase();

	if (playerSelection == computerSelection) {
		console.log(playerSelection + " is equal to " + computerSelection);
		return "tie"
	}

	const win = new Set([
		"rock,scissors",
		"scissors,paper",
		"paper,rock"
	]);

	if (win.has(playerSelection + "," + computerSelection)){
		console.log(playerSelection + " beats " + computerSelection);
		return "player";
	}

	console.log(playerSelection + " loses to " + computerSelection);
	return "cpu";
}

function game() {
	let score = {
		"player" : 0,
		"cpu" : 0,
		"tie" : 0
	}

	for (let i = 0; i < 5; i++) {
		score[playRound(getPlayerChoice(i + 1), getComputerChoice())]++;
	}

	console.log("Final Score:");
	console.log("Player: " + score["player"]);
	console.log("CPU: " + score["cpu"]);
}

game();