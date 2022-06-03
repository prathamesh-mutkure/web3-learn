const ItemManager = artifacts.require("./ItemManager.sol");

contract("ItemManager", (accounts) => {
  it("... should be able to add items", async function () {
    const itemManagerInstance = await ItemManager.deployed();
    const itemName = "test";
    const itemCost = 500;

    const result = await itemManagerInstance.createItem(itemName, itemCost, {
      from: accounts[0],
    });

    const { index, itemAddress } = result.logs[0].args;
    const itemIndex = index.toNumber();

    // Checking for the item to be the first in that mapping
    assert.equal(itemIndex, 0, "This isn't the first item");

    const item = await itemManagerInstance.items(itemIndex);

    assert.equal(item.identifier, itemName, "The identifer doesn't match");
  });
});

// Truffle re-deploys the smart contract for testing purpose
// Thus, the smart contract is empty
// Atleast, for the firt test case
// Truffle discards the address at which the contract is stored at
// Thus, it is lost forever
