// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

import "./Allowance.sol";

contract SharedWalletProject is Allowance {
    event MoneyRecieved(address _from, uint256 _amount);
    event MoneySent(address _benificiery, uint256 _amount);

    function getTotalBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function withdraw(address payable _to, uint256 _amount)
        public
        ownedOrAllowed(_amount)
    {
        require(_amount <= address(this).balance, "Insifficient Funds");

        if (!isOwner()) {
            reduceAllowance(msg.sender, _amount);
        }
        emit MoneySent(_to, _amount);
        _to.transfer(_amount);
    }

    // Oveeriding this method to reverse transaction
    // so that owner cannot be changed
    function renounceOwnership() public override view ownerOnly {
        revert("Renouncing ownership not possible with this contract");
    }

    receive() external payable {
        emit MoneyRecieved(msg.sender, msg.value);
    }
}
