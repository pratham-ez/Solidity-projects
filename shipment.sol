// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract ShipmentContract {
    
    address payable public seller;
    address payable public buyer;
    uint public price;
    string public carrier;
    string public shippingMethod;
    uint public deliveryDate;
    uint public penaltyAmount;
    bool public delivered;
    bool public paid;
    
    constructor(
        address payable _seller,
        address payable _buyer,
        uint _price,
        string memory _carrier,
        string memory _shippingMethod,
        uint _deliveryDate,
        uint _penaltyAmount
    ) {
        seller = _seller;
        buyer = _buyer;
        price = _price;
        carrier = _carrier;
        shippingMethod = _shippingMethod;
        deliveryDate = _deliveryDate;
        penaltyAmount = _penaltyAmount;
        delivered = false;
        paid = false;
    }
    
    function confirmDelivery() public payable {
        require(msg.sender == buyer, "Only the buyer can confirm delivery.");
        require(!delivered, "Goods have already been delivered.");
        require(block.timestamp <= deliveryDate, "Delivery date has passed.");
        
        delivered = true;
        
        if (paid) {
            seller.transfer(price);
        }
    }
    
    function confirmPayment() public payable {
        require(msg.sender == seller, "Only the seller can confirm payment.");
        require(delivered, "Goods have not yet been delivered.");
        require(!paid, "Payment has already been made.");
        
        paid = true;
        
        if (delivered) {
            seller.transfer(price);
        } else {
            buyer.transfer(price - penaltyAmount);
            seller.transfer(penaltyAmount);
        }
    }
    
    function cancel() public {
        require(msg.sender == buyer || msg.sender == seller, "Only the buyer or seller can cancel the contract.");
        require(!delivered, "Goods have already been delivered.");
        selfdestruct(payable(seller));
    }
}
