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

contract Allowance is Ownable {
    mapping(address => uint) public allowance;

    event AllowanceChanged(address _forWho, address _byWhom, uint _oldAmount, uint _newAmount);

    modifier ownedOrAllowed(uint _amount) {
        require(isOwner() || allowance[msg.sender] >= _amount, "Not Allowed");
        _;
    }

    function setAllowance(address _who, uint _amount) ownerOnly public {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
        allowance[_who] = _amount;
    }

    function reduceAllowance(address _who, uint _amount) internal ownedOrAllowed(_amount) {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], allowance[_who] - _amount);
        allowance[_who] -= _amount;
    }
}

contract SharedWalletProject is Allowance {

    event MoneyRecieved(address _from, uint _amount);
    event MoneySent(address _benificiery, uint _amount);

   function getTotalBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    function withdraw(address payable _to, uint _amount) ownedOrAllowed(_amount) public {
        require(_amount <= address(this).balance, "Insifficient Funds");

        if (!isOwner()) {
            reduceAllowance(msg.sender, _amount);
        }
        emit MoneySent(_to, _amount);
        _to.transfer(_amount);
    }

    // Oveeriding this method to reverse transaction
    // so that owner cannot be changed
    function renounceOwnership() public view override ownerOnly {
        revert("Renouncing ownership not possible with this contract");
    }

    receive() payable external {
        emit MoneyRecieved(msg.sender, msg.value);
    }

}
