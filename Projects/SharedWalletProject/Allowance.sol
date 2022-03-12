// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

import "./Ownable.sol";

contract Allowance is Ownable {
    mapping(address => uint256) public allowance;

    event AllowanceChanged(
        address _forWho,
        address _byWhom,
        uint256 _oldAmount,
        uint256 _newAmount
    );

    modifier ownedOrAllowed(uint256 _amount) {
        require(isOwner() || allowance[msg.sender] >= _amount, "Not Allowed");
        _;
    }

    function setAllowance(address _who, uint256 _amount) public ownerOnly {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
        allowance[_who] = _amount;
    }

    function reduceAllowance(address _who, uint256 _amount)
        internal
        ownedOrAllowed(_amount)
    {
        emit AllowanceChanged(
            _who,
            msg.sender,
            allowance[_who],
            allowance[_who] - _amount
        );
        allowance[_who] -= _amount;
    }
}
