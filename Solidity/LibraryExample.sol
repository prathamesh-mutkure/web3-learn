// SPDX-License-Identifier: MIT

// Using old version, so that images can rollover
pragma solidity ^0.5.13;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.3.0/contracts/math/SafeMath.sol";

contract LicenseExample {

    using SafeMath for uint;

    mapping(address => uint) public tokenBalance;

    constructor() public {
        tokenBalance[msg.sender] = 1;
    }

    // uint rolls over
    function sendToken(address _to, uint _amount) public returns(bool) {
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;

        return true;
    }

    // using ... for ...
    // Using SafeMath library on uint
    // This will pass value of uint variable to first argument of library method
    // uint_val.add(val1, val2)
    // In this case, uint_val will be passed over to val1 and 
    // functions will be called accordingly 
    function sendTokenSafe(address _to, uint _amount) public returns(bool) {
        tokenBalance[msg.sender] = tokenBalance[msg.sender].sub(_amount);
        tokenBalance[_to] = tokenBalance[_to].add(_amount);

        return true;
    }

    function getMyBalance() public view returns(uint) {
        return tokenBalance[msg.sender];
    }

}
