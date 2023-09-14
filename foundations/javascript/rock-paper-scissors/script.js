const score = {
	"player" : 0,
	"cpu" : 0,
	"tie" : 0
}

const win = new Set([
	"rock,scissors",
	"scissors,paper",
	"paper,rock"
]);

const cpu      = document.getElementById("cpu-score");
const player   = document.getElementById("player-score");
const cpuImage = document.getElementById("cpu-option");

function randomChoice(array) {
	if (!Array.isArray(array) || array.length === 0)
		return undefined;
	return array[Math.floor(Math.random() * array.length)];
}

function getComputerChoice() {
	return randomChoice(["rock", "paper", "scissors"]);
}

function playRound(playerSelection, computerSelection) {
	if (playerSelection === computerSelection)
		return "tie";

	if (win.has(playerSelection + "," + computerSelection))
		return "player";

	return "cpu";
}

function updateScoreDocument() {
	cpu.textContent    = score["cpu"];
	player.textContent = score["player"];
}

// Graphics
const animationsQueue = []

function cpuAnimation(maxWidth, duration, newImage, callback) {
	let currentWidth = cpuImage.width;
	let targetWidth = 0;
	let frameRate = 60;

	let deltaWidth = (targetWidth - currentWidth) / (duration * frameRate);

	function shrink() {
		if (currentWidth > targetWidth) {
			currentWidth += deltaWidth;
			currentWidth  = Math.max(currentWidth, 0);
			cpuImage.style.width = currentWidth + "px";
			requestAnimationFrame(shrink);
		} else {
			deltaWidth  *= -1;
			cpuImage.src = newImage;
			const nextAnimation = animationsQueue.shift();
			if (nextAnimation)
				nextAnimation();
		}
	}

	function expand() {
		if (currentWidth < maxWidth) {
			currentWidth += deltaWidth;
			currentWidth  = Math.min(currentWidth, maxWidth);
			cpuImage.style.width = currentWidth + "px";
			requestAnimationFrame(expand);
		}
		else {
			const nextAnimation = animationsQueue.shift();
			if (nextAnimation)
				nextAnimation();
			else if (callback)
				callback();
		}
	}
	
	shrink();
	animationsQueue.push(() => {
		expand();
	});
}

// Event Handler
const buttons = document.querySelectorAll("button");

function disableButtons() {
	buttons.forEach(button => {
		button.disabled = true;
	});
}

function enableButtons() {
	buttons.forEach(button => {
		button.disabled = false;
	});
}

const options = document.querySelectorAll(".rps-option");
options.forEach((button, index) => {
	button.addEventListener("click", function() {
		disableButtons();
		let cpuChoice = getComputerChoice();
		cpuAnimation(265, 0.25, "./images/" + cpuChoice + ".png");
		score[playRound(this.id, cpuChoice)]++;
		updateScoreDocument();
		setTimeout(() => {
			cpuAnimation(265, 0.25, "./images/blank.png", enableButtons);
		}, 2000);	
	});
});