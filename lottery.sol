// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract Lottery{
    
     address public manager;
     address payable[] public participants;

     constructor(){
         manager = msg.sender;
     }
     
     receive() external payable {
         
         require(msg.value == 0.1 ether);

         participants.push(payable(msg.sender));
     }

     function getBalance() public view returns(uint){
         require(msg.sender==manager);
         return address(this).balance;
     }

     function randomNumber() public view returns(uint){
     return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participants.length)));

     }

     function winner() public {
         require(msg.sender==manager);
         require(participants.length>=3);
          
         uint r = randomNumber ();
         address payable winneraddress;
         uint index = r % participants.length;
         winneraddress = participants[index];
         winneraddress.transfer(getBalance());
         participants=new address payable[](0);
        
     }
     

}
