// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract WillThrowError {
    function aFunction() public pure {
        require(false, "Error Handling Demo");
    }
}

contract ErrorHandling {
    event ErrorLogging(string reason);

    function catchError() public {

        WillThrowError willThrowError = new WillThrowError();

        try willThrowError.aFunction() {
            // Do something if it works
        } catch Error(string memory error) {
            emit ErrorLogging(error);
        }
    }
}