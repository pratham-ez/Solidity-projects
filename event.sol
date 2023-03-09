// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract Event {
    struct EventInfo {
      address organizer;
      string Event_name;
      uint date;
      uint price;
      uint totalTickets;
      uint remainingTickets;
    }

    mapping(uint => EventInfo ) public events;
    mapping(address=>mapping(uint=>uint)) public tickets;
    
    uint public nextId ;

    function createEvent(string memory name , uint date ,uint price , uint totalTickets )external {
        require(date>block.timestamp,"You cannot organize an event on past dates");
        require(totalTickets>0,"event cannot ahve 0 tickets");

        events[nextId] = EventInfo(msg.sender,name,date,price,totalTickets,totalTickets);
        nextId++;
    }
    
    function buyTicket(uint id,uint quantity) external payable {
        require(events[id].date!=0,"this event does not exists");
        require(block.timestamp < events[id].date ,"event is over");
        EventInfo storage _event = events[id];
        
        // require(msg.value==(_event.price*quantity),"Not enough ethers");

        require(_event.remainingTickets>=quantity,"tickets are sold");
        _event.remainingTickets -= quantity;

         tickets[msg.sender][id]+=quantity;

    }

    function transferTickets(uint id , uint quantity , address to) external {
         require(events[id].date!=0);
         require(events[id].date>block.timestamp);
         require(tickets[msg.sender][id]>= quantity,"Lavde paise kama fir tickets kharid fir item ke samne maaj kar");
         tickets[msg.sender][id]-=quantity;
         tickets[to][id]+=quantity;
    }

}