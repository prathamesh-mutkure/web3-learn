// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract ItemManager {
    enum SupplyChainSteps {
        Created,
        Paid,
        Delivered
    }

    event SupplyChainStepEvent(uint256 _index, SupplyChainSteps _step);

    struct Item {
        string identifier;
        uint256 price;
        ItemManager.SupplyChainSteps step;
    }

    mapping(uint256 => Item) public items;
    uint256 index;

    // Create Item
    // Store it in items
    // And emit event
    function createItem(string memory _identifier, uint256 _price) public {
        items[index].identifier = _identifier;
        items[index].price = _price;
        items[index].step = SupplyChainSteps.Created;

        emit SupplyChainStepEvent(index, items[index].step);

        index++;
    }

    // Trigger Payment
    function triggerPayment(uint256 _index) public payable {
        require(items[_index].price == msg.value, "Full payment only!");
        require(
            items[_index].step == SupplyChainSteps.Created,
            "Item further in Supply Chain"
        );

        items[_index].step = SupplyChainSteps.Paid;

        emit SupplyChainStepEvent(_index, items[_index].step);
    }

    // Trigger Delivery
    function triggerDelivery(uint256 _index) public {
        require(
            items[_index].step == SupplyChainSteps.Paid,
            "Item further in Supply Chain"
        );

        items[_index].step = SupplyChainSteps.Delivered;

        emit SupplyChainStepEvent(_index, items[_index].step);
    }
}

// PROBLEMS WITH THIS APPROACH:
// User will have to enter the index manually
// Ideally, the user should just be able to send money to the address
// And nothing else
