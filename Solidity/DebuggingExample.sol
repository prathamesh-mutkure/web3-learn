// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract DebuggingExample {

    uint public myInt;
    string public myString = "Hello Solidity";

    function setMyInt(uint _val) public {
        myInt = _val;
    }
}

