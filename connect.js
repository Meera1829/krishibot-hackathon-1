

window.addEventListener("load", async () => {
if (window.ethereum) {
try {
await window.ethereum.request({ method: "eth_requestAccounts" });
console.log("Connected to MetaMask");
} catch (err) {
console.log("User denied MetaMask connection");
}
} else {
alert("Please install MetaMask to use this app");
}
});

