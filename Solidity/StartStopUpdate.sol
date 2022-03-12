// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

contract StartStopUpdate {
    address public owner;
    bool public paused;

    constructor() {
        owner = msg.sender;
    }

    function setPaused(bool _paused) public {
        require(msg.sender == owner, "You're not the owner");
        paused = _paused;
    }

    function receiveMoney() public payable {

    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function withdrawAllMoney(address payable _to) public {
        require(msg.sender == owner, "You're not the owner");
        require(!paused, "Contract is paused");
        _to.transfer(address(this).balance);
    }

    function destroySmartContract(address payable _to) public {
        require(msg.sender == owner, "You're not the owner");
        selfdestruct(_to);
    }
}