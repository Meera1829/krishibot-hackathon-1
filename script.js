// Sample crop prices (simulate AI)
const prices = {
onion: { Erode: 23, Salem: 22, Madurai: 21 },
tomato: { Erode: 20, Salem: 18, Madurai: 19 },
wheat: { Erode: 28, Salem: 29, Madurai: 30 }
};

document.getElementById("cropForm").addEventListener("submit", function (e) {
e.preventDefault();

const crop = document.getElementById("crop").value;
const location = document.getElementById("location").value;

const price = prices[crop][location];

document.getElementById("predictedPrice").innerText = ₹${price}/kg at ${location} Market;
document.getElementById("resultCard").style.display = "block";
});

