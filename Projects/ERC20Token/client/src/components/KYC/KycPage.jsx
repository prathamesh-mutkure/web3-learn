import React, { useState } from "react";
import { useEth } from "../../contexts/EthContext";

const KYCPage = () => {
  const {
    state: { kycContract, accounts },
  } = useEth();
  const [accountAddress, setAccountAddress] = useState("");

  const handleInputChange = (event) => {
    setAccountAddress(event.target.value);
  };

  const whitelistClick = async () => {
    try {
      console.log("Accounts: ", accounts);
      await kycContract.methods
        .setKycComplete(accountAddress)
        .send({ from: accounts[0] });

      alert("Whitelisted " + accountAddress);
    } catch (e) {
      console.log(e);
      alert("Error whitelisting account");
    }
  };

  return (
    <div style={{ textAlign: "center" }}>
      <h1>StarDucks Cappuchino</h1>
      <hr />
      <h3>KYC for Accounts</h3>
      <hr />
      Account to whitelist:{" "}
      <input
        type="text"
        name="accountAddress"
        id="accountAddress"
        value={accountAddress}
        onChange={handleInputChange}
      />{" "}
      <input type="button" value="VERIFY" onClick={whitelistClick} />
    </div>
  );
};

export default KYCPage;
