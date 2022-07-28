const MyToken = artifacts.require("MyToken");
const MyTokenSale = artifacts.require("MyTokenSale");
const KycContract = artifacts.require("KycContract");

require("dotenv").config({ path: "../.env" });

const chai = require("./chaisetup");
const BN = web3.utils.BN;
const expect = chai.expect;

contract("MyTokenSale test", async (accounts) => {
  const [deployerAccount, recipient] = accounts;

  it("...the deployer account should have no balance", async () => {
    const instance = await MyToken.deployed();

    return await expect(
      instance.balanceOf(deployerAccount)
    ).to.eventually.be.a.bignumber.equal(new BN(0));
  });

  it("..all tokens should be in MyTokenSale Contract", async () => {
    const instance = await MyToken.deployed();

    return await expect(
      instance.balanceOf(MyTokenSale.address)
    ).to.eventually.be.a.bignumber.equal(new BN(await instance.totalSupply()));
  });

  it("...should reject non-kyc transaction", async () => {
    const myTokenSaleInstance = await MyTokenSale.deployed();
    const AMOUNT = 1;

    await expect(myTokenSaleInstance.send(AMOUNT, { from: recipient })).to
      .eventually.be.rejected;
  });

  it("...should be possible to buy tokens", async () => {
    const myTokenInstance = await MyToken.deployed();
    const myTokenSaleInstance = await MyTokenSale.deployed();
    const kycContractInstance = await KycContract.deployed();
    const AMOUNT = 1;

    const balanceBefore = await myTokenInstance.balanceOf(recipient);

    await kycContractInstance.setKycComplete(recipient, {
      from: deployerAccount,
    });

    await expect(myTokenSaleInstance.send(AMOUNT, { from: recipient })).to
      .eventually.be.fulfilled;

    return await expect(
      myTokenInstance.balanceOf(recipient)
    ).to.eventually.be.a.bignumber.equal(balanceBefore.add(new BN(AMOUNT)));
  });
});
