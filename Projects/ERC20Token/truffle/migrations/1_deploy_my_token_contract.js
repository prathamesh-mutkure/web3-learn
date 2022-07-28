const MyToken = artifacts.require("MyToken");
const MyTokenSale = artifacts.require("MyTokenSale");

require("dotenv").config({ path: "../.env" });

module.exports = async function (deployer) {
  const accounts = await web3.eth.getAccounts();

  await deployer.deploy(MyToken, process.env.INITIAL_SUPPLY);
  await deployer.deploy(MyTokenSale, 1, accounts[0], MyToken.address);

  const instance = await MyToken.deployed();
  await instance.transfer(MyTokenSale.address, process.env.INITIAL_SUPPLY);
};
