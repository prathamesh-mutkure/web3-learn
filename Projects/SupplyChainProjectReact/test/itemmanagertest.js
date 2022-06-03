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

    assert.equal(itemIndex, 0, "This isn't the first item");

    const item = await itemManagerInstance.items(itemIndex);

    assert.equal(item.identifier, itemName, "The identifer doesn't match");
  });
});
