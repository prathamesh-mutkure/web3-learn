const MyConreact = artifacts.require("MyContract");

module.exports = function (deployer) {
  deployer.deploy(MyConreact, 1000);
};
