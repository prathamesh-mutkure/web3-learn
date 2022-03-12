// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

contract SimpleMappingExample {
    mapping(uint => bool) public myMapping;
    mapping(address => uint) public myBalances;
    mapping(uint => mapping(uint => bool)) myNestedMapping;

    function setMyMapping(uint _index) public {
        myMapping[_index] = true;
    }

    function setMyBalances(uint _balance) public {
        myBalances[msg.sender] = _balance;
    }

    function setMyNestedMapping(uint _index1, uint _index2, bool _bool) public {
        myNestedMapping[_index1][_index2] = _bool;
    }

    function getMyNestedMapping(uint _index1, uint _index2) public view returns(bool) {
        return myNestedMapping[_index1][_index2];
    }
}
