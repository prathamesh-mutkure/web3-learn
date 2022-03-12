// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract PureViewFunctions {

    address owner;
    mapping(address => uint) balance;

    constructor() {
        owner = msg.sender;
    }

    function destroyContract() public {
        require(msg.sender == owner, "You're not the owner");
        selfdestruct(payable(msg.sender));
    }

    // NORMAT FUNCTION
    // CAN CALL ANY FUNCTION
    // READ AND WRITE ALL DATA
    function recieveMoney() public payable {
        assert(balance[msg.sender] + msg.value >= balance[msg.sender]);
        balance[msg.sender] = msg.value;
    }

    // VIEW FUNCTION
    // CAN ONLY READ STORAGE VARIABLES
    // CANNOT CALL WRITING FUNCTIONS
    // BUT CAN CALL PURE FUNCTIONS
    function getOwner() public view returns(address) {
        return owner;
    }

    function getBalance() public view returns(uint) {
        return weiToEther(address(this).balance);
    }

    // PURE FUNCTION
    // CANNOT READ OR WRITE STORAGE VARIABLES
    // CAN CALL OTHER PURE FUNCTIONS
    // BUT CAN NOT CALL VIEW OR WRITING FUNCTION
    function weiToEther(uint _amountInWei) public pure returns(uint) {
        return _amountInWei / 1 ether;
    }

    // RECEIVE FALLBACK FUNCTION:
    // CALLED WHEN WE NEED TO SEND MONEY DIRECTLY
    // TO THE SMART CONTRACT ADDRESS
    receive() external payable {
        recieveMoney();
    }

    // FALLBACK FUNCTION:
    // CALLED IF NONE OF THE FUNCTION MATCH GIVEN FUNCTION SIGNATURE
    // OR
    // NO DATA WAS SUPPLIED AND NO RECIEVE ETHER FUNCTION
    // IT CAN ALSO RECIEVE ETHER IF MARKED PAYABLE
    // CAN ONLY BE CALLED EXTERNALLY
    fallback () external {

    }

    // PUBLIC:
    // Can be called Internally and Externally by anyone

    // PRIVATE:
    // Can Only be called by contract
    // Not by external or derived contracts

    // EXTERNAL:
    // Can be called from other contracts
    // Can be called externally

    // INTERNAL:
    // Can be called by contract
    // OR derived contracts
    // Like protected visibility

}
