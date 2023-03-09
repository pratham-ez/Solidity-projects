// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract SupplyChain {
    address payable public owner1;
    address payable public owner2;
    uint256 public amount1;
    uint256 public amount2;
    bool public productTransferred;

    constructor(address payable _owner1, address payable _owner2)  {
        owner1 = _owner1;
        owner2 = _owner2;
    }

    function deposit1() public payable {
        require(msg.sender == owner1, "Only owner1 can deposit");
        amount1 = msg.value;
    }

    function deposit2() public payable {
        require(msg.sender == owner2, "Only owner2 can deposit");
        amount2 = msg.value;
    }

    function transferProduct() public {
        require(msg.sender == owner2, "Only owner2 can transfer the product");
        productTransferred = true;
    }

    function refund() public {
        require(productTransferred, "Product must be transferred before refund");
        require(msg.sender == owner1, "Only owner1 can claim the refund");
        owner1.transfer(amount1);
        owner2.transfer(amount2);
    }

    function getOwner1() public view returns (address) {
        return owner1;
    }

    function getOwner2() public view returns (address) {
        return owner2;
    }
}
