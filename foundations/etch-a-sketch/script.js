
const SKETCHPAD_WIDTH   = "500px";
const SKETCHPAD_HEIGHT  = "500px";
const DEFAULT_GRID_SIZE = 16;

let mouseDown = {
	"left" : false,
	"right": false
}

const sketchPad = document.getElementById("sketch-pad");
sketchPad.style.width  = SKETCHPAD_WIDTH;
sketchPad.style.height = SKETCHPAD_HEIGHT;

let squares;
let currentColor = "#FF0000";

function createGrid(size) {
	sketchPad.innerHTML = "";

	let row;
	let square;

	for (let y = 0; y < size; y++) {
		row = document.createElement("div");
		row.className = "row";
		for (let x = 0; x < size; x++) {
			square = document.createElement("div");
			square.className = "square";
			row.appendChild(square);
		}
		sketchPad.appendChild(row);
	}
}

function fillSquare(div) {
	switch (mouseState) {
		case colorButton:
			div.style.backgroundColor = currentColor;
			break;
		case rainbowButton:
			div.style.backgroundColor = "rgb(" +
				Math.floor(Math.random() * 256) + ", " +
				Math.floor(Math.random() * 256) + ", " +
				Math.floor(Math.random() * 256) + ")";
			break;
		case eraseButton:
			div.style.backgroundColor = "#FFFFFF";
			break;
	}
}

function updateSquares() {
	squares = document.querySelectorAll(".square");

	squares.forEach((div) => {
		div.addEventListener("mousedown", () => {
			fillSquare(div);
		});
		div.addEventListener("mouseover", () => {
			if (mouseDown["left"])
				fillSquare(div);
		});
  });
}

function resetSquares() {
	squares.forEach((div) => {
		div.style.backgroundColor = "#FFFFFF";
	});
}

// Color Picker
const colorPicker = document.getElementById("color-picker");

colorPicker.addEventListener("input", () => {
	currentColor = colorPicker.value;
});

// Buttons
const colorButton   = document.getElementById("color-button");
const rainbowButton = document.getElementById("rainbow-button");
const eraseButton   = document.getElementById("erase-button");
const clearButton   = document.getElementById("clear-button");

let mouseState = colorButton;

function updateMouseState(button) {
	if (mouseState)
		mouseState.classList.remove("active");
	button.classList.add("active");
	mouseState = button;
}

colorButton.addEventListener("click", () => {
	updateMouseState(colorButton);
});

rainbowButton.addEventListener("click", () => {
	updateMouseState(rainbowButton);
});

eraseButton.addEventListener("click", () => {
	updateMouseState(eraseButton);
});

clearButton.addEventListener("click", () => {
	resetSquares();
});

// Slider
const slider      = document.getElementById("slider");
const sliderValue = document.getElementById("slider-value");
sliderValue.textContent = updateSliderValue(DEFAULT_GRID_SIZE);

function updateSliderValue(num) {
	return num + " x " + num;
}

slider.addEventListener("input", () => {
	sliderValue.textContent = updateSliderValue(slider.value);
	createGrid(slider.value);
	updateSquares();
});

// Event Handlers
document.addEventListener("mousedown", (event) => {
	if (event.button === 0) {
		mouseDown["left"] = true;
	}
});

document.addEventListener("mouseup", (event) => {
	if (event.button === 0) {
		mouseDown["left"] = false;
	}
});

// Initialization
createGrid(DEFAULT_GRID_SIZE);
updateSquares();