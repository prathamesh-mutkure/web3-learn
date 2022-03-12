// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

contract Ownable {
    address private owner;
    
    constructor() {
        owner = msg.sender;
    }

    function isOwner() internal view returns(bool) {
        return msg.sender == owner;
    }

    modifier ownerOnly() {
        require(msg.sender == owner, "You're not the owner");
        _;
    }

    function renounceOwnership() public virtual ownerOnly  {
        owner = address(0);
    }
}