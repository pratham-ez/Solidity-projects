// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract MaintenanceContract {
    
    address payable public owner;
    uint public maintenanceCost;
    uint public lastMaintenanceDate;
    uint constant private SECONDS_PER_YEAR = 31536000; // 365.25 days
    
    constructor(
        address payable _owner,
        uint _maintenanceCost
    ) {
        owner = _owner;
        maintenanceCost = _maintenanceCost;
        lastMaintenanceDate = block.timestamp;
    }
    
    function performMaintenance() public payable {
        require(msg.sender == owner, "Only the owner can perform maintenance.");
        require(block.timestamp >= lastMaintenanceDate + SECONDS_PER_YEAR, "Maintenance can only be performed once per year.");
        
        lastMaintenanceDate = block.timestamp;
        owner.transfer(maintenanceCost);
    }
    
    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }
}
