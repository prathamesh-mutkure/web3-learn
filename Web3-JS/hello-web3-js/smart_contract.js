import Web3 from "web3";

console.clear();

const web3 = new Web3(new Web3.providers.HttpProvider("HTTP://127.0.0.1:7545"));

const accounts = await web3.eth.getAccounts();

/* Deploying MyContract.sol to Ganache */

const CONTRACT_ADDRESS = "0x419F540389a35D234a6ad438910aAf5f3eF106ab";
const ABI_ARRAY = [
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_myUint",
        type: "uint256",
      },
    ],
    name: "setUint",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "myUint",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
];

/* Calling MyUint getter with hardcoded data(hash of function) */

await web3.eth
  .call({
    from: accounts[0],
    to: CONTRACT_ADDRESS,
    data: "0x06540f7e",
  })
  .then((val) => {
    console.log("\nCALL myUint():", val);
  })
  .catch(console.error);

/* Calling MyUint getter with by calculating data(hash of function) */

await web3.eth
  .call({
    from: accounts[0],
    to: CONTRACT_ADDRESS,
    data: web3.utils.sha3("myUint()").substring(0, 10),
  })
  .then((val) => {
    console.log("\nCALL myUint():", val);
  })
  .catch(console.error);

/* Creating MyContract object using ABI Array (from Remix) */

const myContract = new web3.eth.Contract(ABI_ARRAY, CONTRACT_ADDRESS);
console.log("\nContract Methods: ", myContract.methods);

/* Calling MyUint getter using contract object */

await myContract.methods
  .myUint()
  .call()
  .then((val) => console.log("\nmyUint(): ", val))
  .catch(console.error);

/* Transacting setUint() function using contract object */

await myContract.methods
  .setUint(100)
  .send({ from: accounts[0] })
  .then((val) => console.log("\n\nTransaction Receipt: ", val))
  .catch(console.error);
