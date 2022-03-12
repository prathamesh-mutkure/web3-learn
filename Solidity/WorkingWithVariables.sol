// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

contract WorkingWithVariables {
    uint256 public myInt;
    bool public myBool;
    uint8 public myInt8;
    address public myAddress;
    string public myString;

    function setMyInt(uint _myInt) public {
        myInt = _myInt;
    }

    function setMyBool(bool _myBool) public {
        myBool = _myBool;
    }

    function incrementMyInt8() public {
        myInt8++;
    }

    function decrementMyInt8() public {
        myInt8--;
    }

    function setMyAddress(address _myAddress) public {
        myAddress = _myAddress;
    }

    function getBalance() public view returns(uint) {
        return myAddress.balance;
    }

    function setString(string memory _myString) public {
        myString = _myString;
    }
}