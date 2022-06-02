import React, { Component } from "react";
import ItemManagerContract from "./contracts/ItemManager.json";
import ItemContract from "./contracts/Item.json";
import getWeb3 from "./getWeb3";

import "./App.css";

class App extends Component {
  state = { itemName: "abc", cost: 100, loaded: false };

  componentDidMount = async () => {
    try {
      // Get network provider and web3 instance.
      this.web3 = await getWeb3();

      // Use web3 to get the user's accounts.
      this.accounts = await this.web3.eth.getAccounts();

      // Get the network ID
      const networkId = await this.web3.eth.net.getId();

      // Get contract instance
      // The json files generated after migrate contain the contract's address
      // We can use that and ABI array to create instance of it
      this.itemManager = new this.web3.eth.Contract(
        ItemManagerContract.abi,
        ItemManagerContract.networks[networkId] &&
          ItemManagerContract.networks[networkId].address
      );

      this.item = new this.web3.eth.Contract(
        ItemContract.abi,
        ItemContract.networks[networkId] &&
          ItemContract.networks[networkId].address
      );

      // Web3, Contracts and Accounts loaded

      this.listenToPayments();
      this.setState({ loaded: true });
    } catch (error) {
      // Catch any errors for any of the above operations.
      alert(
        `Failed to load web3, accounts, or contract. Check console for details.`
      );
      console.error(error);
    }
  };

  handleChange = (event) => {
    this.setState({ [event.target.name]: event.target.value });
  };

  // Call createItem() method of ItemManager contract
  handleSubmit = async () => {
    const { itemName, cost } = this.state;

    const result = await this.itemManager.methods
      .createItem(itemName, cost)
      .send({ from: this.accounts[0] });

    const itemAddress = result.events.SupplyChainEvent.returnValues.itemAddress;

    console.log("RESULT: ", result);

    alert(`Send ${cost} Wei to ${itemAddress}`);
  };

  // This method listens to the SupplyChainEvent
  listenToPayments = async () => {
    const self = this;

    this.itemManager.events
      .SupplyChainEvent()
      .on("data", async function (event) {
        console.log("EVENT: ", event);

        const { index, itemAddress, step } = event.returnValues;

        // Get the item contract at index return by event
        const item = await self.itemManager.methods.items(index).call();

        if (step == 0) {
          console.log(
            `Item "${item.identifier}" created at address ${itemAddress} at index - ${index}`
          );
        } else if (step == 1) {
          console.log(`Item "${item.identifier}" was paid`);

          alert(`Item "${item.identifier}" was paid, deliver it now!`);
        } else if (step == 2) {
          console.log(`Item "${item.identifier}" was delivered!`);

          alert(`Item "${item.identifier}" was delivered!`);
        }
      });
  };

  render() {
    if (!this.state.loaded) {
      return <div>Loading Web3, accounts, and contract...</div>;
    }

    return (
      <div className="App">
        <h1>Payment Supply Chain Example</h1>
        <h2>Add Item</h2>

        <div>
          Item Name:
          <input
            type="text"
            name="itemName"
            value={this.state.itemName}
            onChange={this.handleChange}
          />
          <br />
          <br />
          Cost (In Wei):
          <input
            type="number"
            name="cost"
            value={this.state.cost}
            onChange={this.handleChange}
          />
          <br />
          <br />
          <input type="submit" value="Submit" onClick={this.handleSubmit} />
        </div>
      </div>
    );
  }
}

export default App;

// 100 Wei in Ether
// 0.000000000000000100
