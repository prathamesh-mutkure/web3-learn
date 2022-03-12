// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

// IMPORTS:
// No need to deploy parent contract seperately
// It will get compiled when child contract is deployed

import "./OwnedInheritanceExample.sol";

// INHERITANCE:
// Inherit parent contract using "is parent_name"
// Possible to inherit multiple classes

contract ModifierInheritance is Owned {
    
    mapping(address => uint) public tokenBalance;
    uint tokenPrice = 1 ether;

    constructor() {
        tokenBalance[owner] = 100;
    }
    
    function createNewToken() public isOwner {
        tokenBalance[owner]++;
    }

    function burnToken() public isOwner {
        tokenBalance[owner]--;
    }

    function getMyBalance() view public returns(uint) {
        return tokenBalance[msg.sender];
    }

    function purchaseToken() public payable {
        require(tokenBalance[owner] * tokenPrice / msg.value > 0, "Not enough tokens");     // Refactor
        
        tokenBalance[owner] -= msg.value / tokenPrice;
        tokenBalance[msg.sender] += msg.value / tokenPrice;
    }

    function sendToken(address _to, uint _amount) public {

        require(tokenBalance[msg.sender] > _amount, "Not enough tokens");
        assert(tokenBalance[_to] + _amount >= tokenBalance[_to]);
        assert(tokenBalance[msg.sender] - _amount <= tokenBalance[msg.sender]);

        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;
    }
}
