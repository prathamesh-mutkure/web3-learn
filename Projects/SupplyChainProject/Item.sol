// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./ItemManager.sol";

contract Item {
    uint256 public price;
    uint256 public paid;
    uint256 public index;
    ItemManager parentContract;

    constructor(
        ItemManager _parentContract,
        uint256 _index,
        uint256 _price
    ) {
        parentContract = _parentContract;
        index = _index;
        price = _price;
    }

    // Success is true when the called function does't give any error and is executed successfully
    // If called function gives error, then we can use require() to reverse the whole transaction
    receive() external payable {
        require(msg.value == price, "Full Payment Only");
        require(paid == 0, "Already Paid");
        paid += msg.value;

        (bool success, ) = address(parentContract).call{value: msg.value}(
            abi.encodeWithSignature("triggerPayment(uint256)", index)
        );

        require(success, "Error in payment, reverting transaction");
    }

    // Fallback function to be able to interact with smart contract through remix
    fallback() external {}
}
