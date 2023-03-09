// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract QualityControlContract {
    
    address payable public supplier;
    address payable public buyer;
    uint public price;
    uint public penaltyAmount;
    uint public inspectionFee;
    bool public inspected;
    bool public accepted;
    address payable public inspector;
    
    constructor(
        address payable _supplier,
        address payable _buyer,
        uint _price,
        uint _penaltyAmount,
        uint _inspectionFee
    ) {
        supplier = _supplier;
        buyer = _buyer;
        price = _price;
        penaltyAmount = _penaltyAmount;
        inspectionFee = _inspectionFee;
        inspected = false;
        accepted = false;
    }
    
    function requestInspection(address payable _inspector) public payable {
        require(msg.sender == buyer, "Only the buyer can request an inspection.");
        require(!inspected, "Goods have already been inspected.");
        
        inspected = true;
        inspector = _inspector;
        inspector.transfer(inspectionFee);
    }
    
    function confirmAcceptance() public payable {
        require(msg.sender == buyer, "Only the buyer can confirm acceptance.");
        require(inspected, "Goods have not yet been inspected.");
        require(!accepted, "Goods have already been accepted.");
        
        accepted = true;
        supplier.transfer(price);
    }
    
    function confirmRejection() public payable {
        require(msg.sender == buyer, "Only the buyer can confirm rejection.");
        require(inspected, "Goods have not yet been inspected.");
        require(!accepted, "Goods have already been accepted.");
        
        accepted = false;
        buyer.transfer(price - penaltyAmount);
        supplier.transfer(penaltyAmount);
    }
}

