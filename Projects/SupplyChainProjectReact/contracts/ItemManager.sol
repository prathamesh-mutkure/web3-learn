// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./Item.sol";
import "./Ownable.sol";

contract ItemManager is Ownable {
    enum SupplyChainSteps {
        Created,
        Paid,
        Delivered
    }

    struct S_Item {
        Item item;
        string identifier;
        SupplyChainSteps step;
    }

    mapping(uint256 => S_Item) public items;
    uint256 index;

    event SupplyChainEvent(
        uint256 index,
        SupplyChainSteps step,
        address itemAddress
    );

    function createItem(string memory _identifier, uint256 _price)
        public
        onlyOwner
    {
        Item item = new Item(this, index, _price);
        items[index].item = item;
        items[index].identifier = _identifier;
        items[index].step = SupplyChainSteps.Created;

        emit SupplyChainEvent(index, items[index].step, address(item));

        index++;
    }

    // Acess instance variables of external contracts as function
    // Not as variable
    // Because solidity automatically creates getter funciton for public variables
    function triggerPayment(uint256 _index) public payable {
        Item item = items[_index].item;

        require(
            address(item) == msg.sender,
            "Only Item is allowed to update itself"
        );
        require(item.price() == msg.value, "Full payments only");
        require(
            items[_index].step == SupplyChainSteps.Created,
            "Item further in supply chain"
        );

        items[_index].step = SupplyChainSteps.Paid;

        emit SupplyChainEvent(
            _index,
            items[_index].step,
            address(items[_index].item)
        );
    }

    function triggerDelivery(uint256 _index) public onlyOwner {
        require(
            items[_index].step == SupplyChainSteps.Paid,
            "Item is further in Supply Chain"
        );
        items[_index].step = SupplyChainSteps.Delivered;

        emit SupplyChainEvent(
            _index,
            items[_index].step,
            address(items[_index].item)
        );
    }
}
