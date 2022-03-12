// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

// GOOD PRACTICE:
// To keep a contract in seperate file
// 1 component per file

// No need to depoly this seperately
// Compiled with child contract

contract Owned {

    address owner;

    constructor() {
        owner = msg.sender;
    }

    // MODIFIERS:
    // They are like decorators in python
    // The calling function body is copied to the "_"
    // And then returned
    modifier isOwner() {
        require(msg.sender == owner, "You're not the owner");
        _;
    }
}