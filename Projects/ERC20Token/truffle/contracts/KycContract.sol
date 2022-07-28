// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

import "@openzeppelin/contracts/access/Ownable.sol";

contract KycContract is Ownable {
    mapping(address => bool) allowed;

    function setKycComplete(address _address) public onlyOwner {
        allowed[_address] = true;
    }

    function setKycRevoked(address _address) public onlyOwner {
        allowed[_address] = false;
    }

    function isVerified(address _address) public view returns (bool) {
        return allowed[_address];
    }
}
