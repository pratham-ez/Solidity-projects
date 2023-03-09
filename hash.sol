// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract ProductSupplyChain {
    bytes32 public productHash;
    address payable public owner;
    address public currentHandler;
    bool public isProductDelivered;

    event ProductHashGenerated(bytes32 hash);
    event ProductDelivered();

    constructor() {
        owner = payable(msg.sender);
        currentHandler = owner;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner of the contract can call this function");
        _;
    }

    modifier onlyHandler() {
        require(msg.sender == currentHandler, "Only the current handler of the product can call this function");
        _;
    }

    function generateProductHash(bytes32 hash) public onlyOwner {
        productHash = hash;
        emit ProductHashGenerated(hash);
    }

    function changeHandler(address newHandler) public onlyHandler {
        currentHandler = newHandler;
    }

    function deliverProduct() public onlyOwner {
        isProductDelivered = true;
        emit ProductDelivered();
    }

    function checkProductHash(bytes32 newHash) public onlyHandler {
        require(!isProductDelivered, "Product has already been delivered");
        require(newHash != productHash, "Product hash is still the same");
        selfdestruct(owner);
    }
}
