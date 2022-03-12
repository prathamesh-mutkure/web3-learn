// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

contract SendMoneyExample {

    uint public balanceReceived;
    uint public lockedUntil;
    

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function recieveMoney() public payable {
        lockedUntil = block.timestamp + 10 seconds;
        balanceReceived += msg.value;
    }

    function withdrawMoney() public {
        if (block.timestamp >= lockedUntil) {
            address to = msg.sender;
            payable(to).transfer(this.getBalance());
        }
        
    }

    function withdrawMoneyTo(address payable _to) public {
        if (block.timestamp >= lockedUntil) {
            _to.transfer(this.getBalance());
        }
    }
}