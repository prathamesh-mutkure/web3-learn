// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract StructExample {

    struct Payment {
        uint _amount;
        uint timestamp;
    }

    struct Balance {
        uint totalBalance;
        uint numPayments;
        mapping(uint => Payment) payments;
    }

    mapping(address => Balance) public balance;

    function addMoney() public payable {
        balance[msg.sender].totalBalance += msg.value;

        Payment memory payment = Payment(msg.value, block.timestamp);

        balance[msg.sender].payments[balance[msg.sender].numPayments] = payment;
        balance[msg.sender].numPayments++;
    }

    function getTotalBalance() public view returns(uint) {
        return address(this).balance;
    }

    function getMyBalance() public view returns(uint) {
        return balance[msg.sender].totalBalance;
    }
    
    function getMyPayment(uint _paymentNum) public view returns(Payment memory) {
        return balance[msg.sender].payments[_paymentNum];
    }

    function withdrawMoney(address payable _to, uint _amount) public {

        uint accountBalance = balance[msg.sender].totalBalance;
        require(accountBalance >= _amount, "Insufficient balance");

        balance[msg.sender].totalBalance -= _amount;
        _to.transfer(_amount);
    }

    function withdrawAllMoney(address payable _to) public {

        uint accountBalance =  balance[msg.sender].totalBalance;
        balance[msg.sender].totalBalance = 0;
        _to.transfer(accountBalance);
    }

    // IMPORTANT:
    // First store the state
    // Then update the state
    // Then interact with external network
}