import React, { useState, useCallback, useEffect } from "react";
import { useReducer } from "react";
import { actions, reducer, useEth } from "../../contexts/EthContext";

const BuyTokens = () => {
  const { state } = useEth();

  const {
    tokenContract,
    tokenSaleContract,
    tokenSaleArtifact,
    networkID,
    tokenBalance,
    accounts,
    web3,
  } = state;

  const [balance, setBalance] = useState(tokenBalance);

  const buyToken = async () => {
    await tokenSaleContract.methods
      .buyTokens(accounts[0])
      .send({ from: accounts[0], value: 1 });
  };

  const getTokenBalance = useCallback(async () => {
    const balance = await tokenContract?.methods.balanceOf(accounts[0]).call();

    setBalance(balance);
  }, [accounts, tokenContract]);

  const listenToTokenTransfer = useCallback(() => {
    tokenContract?.events
      .Transfer({ to: accounts[0] })
      .on("data", getTokenBalance);
  }, [tokenContract, accounts, getTokenBalance]);

  useEffect(() => {
    getTokenBalance();
    listenToTokenTransfer();
  }, [getTokenBalance, listenToTokenTransfer]);

  return (
    <div style={{ textAlign: "center" }}>
      <h3>Buy Tokens</h3>
      <hr />

      <p>
        To buy tokens, send Wei to this address:{" "}
        {tokenSaleArtifact?.networks[networkID].address}
      </p>

      <p>Your current balance is: {balance} CAPPU Tokens</p>

      <button onClick={buyToken}>BUY TOKEN</button>
    </div>
  );
};

export default BuyTokens;
