// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only owner is allowed to do this operation"
        );
        _;
    }

    function isOwner() public view returns (bool) {
        return msg.sender == owner;
    }
}
