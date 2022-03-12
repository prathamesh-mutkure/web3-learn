// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract EventExample {

    event sendTokenEvent(address _from, address _to, uint _amount);

    // RETURN VALUES:
    // The return values from function doesn't actually gets returned
    // on JavaScript VM, the value is returned in logs as decoded output
    // BUT
    // on real network, the return value doesn't work
    // to return value in a real network, store them in logs
    // using Events
    function returnSomething(bool val) public pure returns(bool) {
        return val;
    }

    // EVENTS
    // Used to store value in logs
    // The values are stored in decoded output
    // Then outside softwares can listen to this value
    function sendToken(address _to, uint _amount) payable public {
        emit sendTokenEvent(msg.sender, _to, _amount);
    }

}
