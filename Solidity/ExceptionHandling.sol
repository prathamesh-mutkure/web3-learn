// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.12;

contract ExceptionalHandling {
    mapping(address => uint64) public balanceReceived;

    function receiveMoney() public payable {
        assert(msg.value == uint64(msg.value));
        balanceReceived[msg.sender] += uint64(msg.value);
        assert(balanceReceived[msg.sender] >= msg.value);
    }

    function withdrawMoney(address payable _to, uint64 _amount) public {
        require(_amount <= balanceReceived[msg.sender], "Not Enough Funds, aborting");

        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount);

        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
}

// Require ----> To check input and give error message like if-else
// Assert -----> To check internal state of contract variables
