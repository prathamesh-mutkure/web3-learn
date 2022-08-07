// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// import "./ERC20Mintable.sol";

contract MyToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("ERC20 Cappuccino", "ECP") {
        _mint(msg.sender, initialSupply);
    }

    function increaseSupply(address account, uint256 amount) public {
        super._mint(account, amount);
    }
}
