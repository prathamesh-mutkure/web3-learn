const MyToken = artifacts.require("MyToken");

const chai = require("chai");

const BN = web3.utils.BN;
const chaiBN = require("chai-bn")(BN);
chai.use(chaiBN);

const chaiAsPromised = require("chai-as-promised");
chai.use(chaiAsPromised);

const expect = chai.expect;

contract("MyToken", async (accounts) => {
  const [initialHolder, recipient, anotherAccount] = accounts;

  it("...All tokens should be in my account", async () => {
    const instance = await MyToken.deployed();

    const totalSupply = await instance.totalSupply();

    await expect(
      instance.balanceOf(initialHolder)
    ).to.eventually.be.a.bignumber.equal(totalSupply);
  });

  it("...should transfer tokens from one account to another", async () => {
    const sendTokenCount = 1;
    const instance = await MyToken.deployed();
    const totalSupply = await instance.totalSupply();

    await expect(
      instance.balanceOf(initialHolder)
    ).to.eventually.be.a.bignumber.equal(totalSupply);

    await expect(instance.transfer(recipient, sendTokenCount)).to.eventually
      .fulfilled;

    await expect(
      instance.balanceOf(initialHolder)
    ).to.eventually.be.a.bignumber.equal(
      totalSupply.sub(new BN(sendTokenCount))
    );

    await expect(
      instance.balanceOf(recipient)
    ).to.eventually.be.a.bignumber.equal(new BN(sendTokenCount));
  });

  it("...is not possible to send more tokens than available", async () => {
    const instance = await MyToken.deployed();
    const balanceOfDeployer = await instance.balanceOf(initialHolder);

    await expect(instance.transfer(recipient, new BN(balanceOfDeployer + 1))).to
      .eventually.be.rejected;

    await expect(
      instance.balanceOf(initialHolder)
    ).to.eventually.be.a.bignumber.equal(balanceOfDeployer);
  });
});
