// SPDX-License-Identifier: GPL-3.0

 pragma solidity >=0.5.0 <0.9.0;


contract pocketMoney{

address public parent ;
address payable { 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2};
constructor(){
   parent  = msg.sender; 
}

 receive () external payable {
    require(msg.sender == parent);
}

  function getBalance() public view returns(uint){
         require(msg.sender==parent);
         return address(this).balance;
     }

 function transferMoney(uint ammount ) external payable  {
    
    require(ammount <= 2 ether);
   
    son.transfer(getBalance());
    
 }


}
 
