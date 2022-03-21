import Web3 from "web3";

console.clear();

/***** Initialize and connect to Ganache *****/

const web3 = new Web3(new Web3.providers.HttpProvider("HTTP://127.0.0.1:7545"));
// console.log(web3);

const accounts = await web3.eth.getAccounts();
console.log("Account List in Ganache: ");
console.table(accounts);

/***** Get Balance *****/
/***** Conversions *****/

export const printAllAccountBalance = async () => {
  const allAccountBalance = await Promise.all(
    accounts.map(async (acc) => {
      const balanceInWei = await web3.eth.getBalance(acc);
      const balanceInEther =
        web3.utils.fromWei(balanceInWei, "ether") + " ether";

      return { account: acc, balance: balanceInEther };
    })
  );

  console.table(allAccountBalance);
};

await printAllAccountBalance();

/***** Transfer Ether *****/

const transaction = await web3.eth.sendTransaction({
  from: accounts[0],
  to: accounts[1],
  value: web3.utils.toWei("1", "ether"),
});

console.log("Transaction Receipt: \n", transaction);

await printAllAccountBalance();
