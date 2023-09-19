// Output
const currentFormula = document.getElementById("current-formula");
const currentOperand = document.getElementById("current-operand");

const baseOut = {
	 "2" : document.getElementById("bin-out"),
	 "8" : document.getElementById("oct-out"),
	"10" : document.getElementById("dec-out"),
	"16" : document.getElementById("hex-out")
}

// History
const calculatorHistory = document.getElementById("calculator-history");

// Other
let currentBase = 10;
let resetOperand = true;
const outputTokens = [];

// Functions
function updateOuts() {
	baseOut["10"].textContent = parseInt(currentOperand.textContent, currentBase);
	baseOut["16"].textContent = parseInt(baseOut["10"].textContent).toString(16).toUpperCase();
	baseOut[ "8"].textContent = parseInt(baseOut["10"].textContent).toString(8);
	baseOut[ "2"].textContent = parseInt(baseOut["10"].textContent).toString(2);
}

function updateFormula() {
	currentFormula.textContent = "";
	for (let token of outputTokens) {
		if (typeof(token) === "number") {
			token = parseInt(token).toString(currentBase);
			if (currentBase === 16) {
				token = token.toUpperCase();
			}
		}
		currentFormula.textContent += " " + token;
	}
}

function setPrimaryOut(base) {
	if (["2", "8", "10", "16"].includes(base)) {
		currentBase = base;
		currentOperand.textContent = baseOut[base].textContent;
	}
}

function updateKeys() {
	for (const key in operandButtons) {
		operandButtons[key].classList.toggle("disabled", currentBase < parseInt(key, 16) + 1);
	}
}

function clearAll() {
	currentFormula.textContent = "";
	currentOperand.textContent = "0";
	outputTokens.length = 0;
	resetOperand = true;
	updateOuts();
}

function deleteLast() {
	if (currentOperand.textContent.length >= 1) {
		currentOperand.textContent = currentOperand.textContent.slice(0, -1);
	}
	if (currentOperand.textContent.length === 0) {
		currentOperand.textContent = "0";
	}
	updateOuts();
}

function updateOperand(num) {
	if (currentOperand.textContent == "0") {
		currentOperand.textContent = "";
	}
	currentOperand.textContent += num;
}

function loadOperand() {
	if (outputTokens.length === 0 || ( 
			operatorButtons.hasOwnProperty(outputTokens[outputTokens.length - 1]) &&
			outputTokens[outputTokens.length - 1] !== ")")) {
		outputTokens.push(parseInt(currentOperand.textContent, currentBase));
	}
}

function loadOperator(op) {
	if (outputTokens.length > 0 &&
		resetOperand &&
		!["(", ")"].includes(outputTokens[outputTokens.length - 1])) {
		outputTokens[outputTokens.length - 1] = op;
	}
	else {
		outputTokens.push(op);
	}
	resetOperand = true;
}

// Buttons

// Number System
const baseButtons = {
	 "2" : document.getElementById("button-bin"),
	 "8" : document.getElementById("button-oct"),
	"10" : document.getElementById("button-dec"),
	"16" : document.getElementById("button-hex")
}

for (const key in baseButtons) {
	baseButtons[key].addEventListener("click", () => {
		setPrimaryOut(key);
		updateKeys();
		updateFormula();
	});
}

// Operators
operatorButtons = {
	"AND"  : document.getElementById("button-and"),
	"OR"   : document.getElementById("button-or"),
	"NOT"  : document.getElementById("button-not"),
	"NAND" : document.getElementById("button-nand"),
	"NOR"  : document.getElementById("button-nor"),
	"XOR"  : document.getElementById("button-xor"),
	"«"    : document.getElementById("button-shift-left"),
	"»"    : document.getElementById("button-shift-right"),
	"%"    : document.getElementById("button-mod"),
	"÷"    : document.getElementById("button-divide"),
	"x"    : document.getElementById("button-times"),
	"-"    : document.getElementById("button-minus"),
	"+"    : document.getElementById("button-plus")
}

for (const key in operatorButtons) {
	operatorButtons[key].addEventListener("click", () => {
		if (!resetOperand) {
			loadOperand();
		}
		loadOperator(key);
		updateFormula();
	});
}

let parenCounter = 0;

operatorButtons["("] = document.getElementById("button-open-paren");
operatorButtons["("].addEventListener("click", () => {
	if (!resetOperand) {
		loadOperand();
		loadOperator("x");
	}
	outputTokens.push("(");
	updateFormula();
	parenCounter++;
});

operatorButtons[")"] = document.getElementById("button-close-paren");
operatorButtons[")"].addEventListener("click", () => {
	if (parenCounter > 0) {
		loadOperand();
		outputTokens.push(")");
		resetOperand = true;
		updateFormula();
		parenCounter--;
	}
});

// Operands
const operandButtons = {
	"0" : document.getElementById("button-0"),
	"1" : document.getElementById("button-1"),
	"2" : document.getElementById("button-2"),
	"3" : document.getElementById("button-3"),
	"4" : document.getElementById("button-4"),
	"5" : document.getElementById("button-5"),
	"6" : document.getElementById("button-6"),
	"7" : document.getElementById("button-7"),
	"8" : document.getElementById("button-8"),
	"9" : document.getElementById("button-9"),
	"A" : document.getElementById("button-a"),
	"B" : document.getElementById("button-b"),
	"C" : document.getElementById("button-c"),
	"D" : document.getElementById("button-d"),
	"E" : document.getElementById("button-e"),
	"F" : document.getElementById("button-f"),
}

for (const key in operandButtons) {
	operandButtons[key].addEventListener("click", () => {
		if (!operandButtons[key].classList.contains("disabled")) {
			if (resetOperand) {
				currentOperand.textContent = "";
				resetOperand = false;
			}
			updateOperand(key);
			updateOuts();
		}
	});
}

const buttonSign = document.getElementById("button-sign");
buttonSign.classList.add("disabled");
// buttonSign.addEventListener("click", () => {
//
// });

// Etc
const buttonClear = document.getElementById("button-clear");
buttonClear.addEventListener("click", () => {
	clearAll();
});

const buttonDelete = document.getElementById("button-delete");
buttonDelete.addEventListener("click", () => {
	deleteLast();
});

const buttonEquals = document.getElementById("button-equals");
buttonEquals.addEventListener("click", () => {
	console.log("= clicked");
	//shunting yard
	//calculate rpn
	//push to current operand
	//push to history
});

// Start
updateKeys(currentBase);