// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract AddressMappingExample {

    mapping(address => uint) public moneyRecieved;

    function addMoney() public payable {
        moneyRecieved[msg.sender] += msg.value;
    }

    function withdrawMoney(address payable _to, uint amount) public {
        uint balance = moneyRecieved[msg.sender];
        require(balance >= amount, "Insufficient balance");

        moneyRecieved[msg.sender] -= amount;
        _to.transfer(amount);
    }

    function withdrawAllMoney(address payable _to) public {
        uint balance = moneyRecieved[msg.sender];
        moneyRecieved[msg.sender] = 0;
        _to.transfer(balance);
    }

    // IMPORTANT:
    // First store the state
    // Then update the state
    // Then interact with external network
}