const MyToken = artifacts.require("MyToken");

require("dotenv").config({ path: "../.env" });

const chai = require("./chaisetup");
const BN = web3.utils.BN;
const expect = chai.expect;

contract("MyToken", async (accounts) => {
  const [initialHolder, recipient, anotherAccount] = accounts;

  beforeEach(async () => {
    this.myToken = await MyToken.new(process.env.INITIAL_SUPPLY);
  });

  it("...All tokens should be in my account", async () => {
    const instance = this.myToken;

    const totalSupply = await instance.totalSupply();

    return await expect(
      instance.balanceOf(initialHolder)
    ).to.eventually.be.a.bignumber.equal(totalSupply);
  });

  it("...should transfer tokens from one account to another", async () => {
    const sendTokenCount = 1;
    const instance = this.myToken;
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

    return await expect(
      instance.balanceOf(recipient)
    ).to.eventually.be.a.bignumber.equal(new BN(sendTokenCount));
  });

  it("...is not possible to send more tokens than available", async () => {
    const instance = this.myToken;
    const balanceOfDeployer = await instance.balanceOf(initialHolder);

    await expect(instance.transfer(recipient, new BN(balanceOfDeployer + 1))).to
      .eventually.be.rejected;

    return await expect(
      instance.balanceOf(initialHolder)
    ).to.eventually.be.a.bignumber.equal(balanceOfDeployer);
  });
});
