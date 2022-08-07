import React, { useState, useCallback, useEffect } from "react";
import { useEth } from "../../contexts/EthContext";

const TokenSupply = () => {
  const { state } = useEth();

  const { tokenContract, accounts } = state;

  const [tokenSupply, setTokenSupply] = useState(0);

  const getTokenSupply = useCallback(async () => {
    const supply = await tokenContract?.methods?.totalSupply()?.call();

    setTokenSupply(supply);
  }, [tokenContract]);

  const increaseSupply = async () => {
    try {
      const result = await tokenContract?.methods
        ?.increaseSupply(accounts[0], 10)
        .send({ from: accounts[0] });
      console.log("Result: ", result);
    } catch (e) {
      console.log("Error increasing supply: " + e);
    }

    getTokenSupply();
  };

  useEffect(() => {
    getTokenSupply();
  }, [getTokenSupply]);

  return (
    <div style={{ textAlign: "center" }}>
      <hr />

      <p>
        Total Supply is:
        {tokenSupply}
      </p>

      <button onClick={getTokenSupply}>GET SUPPLY</button>
      <p> </p>
      <button onClick={increaseSupply}>+10 SUPPLY</button>
    </div>
  );
};

export default TokenSupply;
