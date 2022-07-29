import React, { useReducer, useCallback, useEffect } from "react";
import Web3 from "web3";
import EthContext from "./EthContext";
import { reducer, actions, initialState } from "./state";

import MyTokenContract from "./../../contracts/MyToken.json";
import MyTokenSaleContract from "./../../contracts/MyTokenSale.json";
import KycContract from "./../../contracts/KycContract.json";

function EthProvider({ children }) {
  const [state, dispatch] = useReducer(reducer, initialState);

  const init = useCallback(
    async (tokenArtifact, tokenSaleArtifact, KycArtifact) => {
      if (tokenArtifact) {
        const web3 = new Web3(Web3.givenProvider || "ws://localhost:8545");
        const accounts = await web3.eth.requestAccounts();
        const networkID = await web3.eth.net.getId();

        let tokenContract, tokenSaleContract, kycContract;

        try {
          tokenContract = new web3.eth.Contract(
            tokenArtifact.abi,
            tokenArtifact.networks[networkID].address
          );
          tokenSaleContract = new web3.eth.Contract(
            tokenSaleArtifact.abi,
            tokenSaleArtifact.networks[networkID].address
          );
          kycContract = new web3.eth.Contract(
            KycArtifact.abi,
            KycArtifact.networks[networkID].address
          );
        } catch (err) {
          console.error(err);
        }

        dispatch({
          type: actions.init,
          data: {
            web3,
            accounts,
            networkID,
            tokenArtifact,
            tokenSaleArtifact,
            KycArtifact,
            tokenContract,
            tokenSaleContract,
            kycContract,
          },
        });
      }
    },
    []
  );

  useEffect(() => {
    const tryInit = async () => {
      try {
        const tokenArtifact = MyTokenContract;
        const tokenSaleArtifact = MyTokenSaleContract;
        const kycArtifact = KycContract;

        init(tokenArtifact, tokenSaleArtifact, kycArtifact);
      } catch (err) {
        console.error(err);
      }
    };

    tryInit();
  }, [init]);

  useEffect(() => {
    const events = ["chainChanged", "accountsChanged"];
    const handleChange = () => {
      init(state.tokenArtifact, state.tokenSaleArtifact, state.kycArtifact);
    };

    events.forEach((e) => window.ethereum.on(e, handleChange));
    return () => {
      events.forEach((e) => window.ethereum.removeListener(e, handleChange));
    };
  }, [init, state.tokenArtifact, state.tokenSaleArtifact, state.kycArtifact]);

  return (
    <EthContext.Provider
      value={{
        state,
        dispatch,
      }}
    >
      {children}
    </EthContext.Provider>
  );
}

export default EthProvider;
