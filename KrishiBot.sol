// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract KrishiBot {

csharp
Copy
Edit
address public admin;

struct Farmer {
    string name;
    string crop;
    uint quantity;
    string location;
    uint pricePerKg;
    bool subsidyClaimed;
}

mapping(address => Farmer) public farmers;

event CropSold(address indexed farmer, string crop, uint quantity, string location, uint price);
event SubsidyReleased(address indexed farmer, uint amount);

constructor() {
    admin = msg.sender; // Deployer becomes the admin
}

function sellCrop(
    string memory _name,
    string memory _crop,
    uint _quantity,
    string memory _location
) public {
    uint price = predictPrice(_crop, _location);
    farmers[msg.sender] = Farmer(_name, _crop, _quantity, _location, price, false);
    emit CropSold(msg.sender, _crop, _quantity, _location, price);
}

function predictPrice(string memory crop, string memory location) internal pure returns (uint) {
    // Simulate price prediction (basic logic)
    if (keccak256(abi.encodePacked(crop)) == keccak256(abi.encodePacked("onion"))) {
        return 23;
    } else if (keccak256(abi.encodePacked(crop)) == keccak256(abi.encodePacked("tomato"))) {
        return 20;
    } else {
        return 25; // default
    }
}

function getFarmerDetails(address farmerAddr) public view returns (
    string memory name,
    string memory crop,
    uint quantity,
    string memory location,
    uint pricePerKg,
    bool subsidyClaimed
) {
    Farmer memory f = farmers[farmerAddr];
    return (f.name, f.crop, f.quantity, f.location, f.pricePerKg, f.subsidyClaimed);
}

function releaseSubsidy(address payable farmerAddr) public {
    require(msg.sender == admin, "Only admin can release subsidy");
    require(!farmers[farmerAddr].subsidyClaimed, "Subsidy already claimed");

    uint amount = 2000 * 1e15; // 0.002 ETH ~ ₹2000 (for testnet)
    farmerAddr.transfer(amount);
    farmers[farmerAddr].subsidyClaimed = true;

    emit SubsidyReleased(farmerAddr, amount);
}

receive() external payable {} 