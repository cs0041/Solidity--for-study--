// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

contract Constructor {

    string message;

    //run  only one time when create smart contract
    //purpose for init some value
    constructor(string memory _message){
        message = _message;
    }

}