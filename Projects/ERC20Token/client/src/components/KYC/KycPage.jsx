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
    await kycContract.methods
      .setKycComplete(accountAddress)
      .send({ from: accounts[0] });

    alert("Whitelisted " + accountAddress);
  };

  return (
    <div>
      Account to whitelist:{" "}
      <input
        type="text"
        name="accountAddress"
        id="accountAddress"
        value={accountAddress}
        onChange={handleInputChange}
      />{" "}
      <input type="button" value="submit" onClick={whitelistClick} />
    </div>
  );
};

export default KYCPage;
