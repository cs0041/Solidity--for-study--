// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

contract Variable {

    //state variables
    int a = -1;
    uint b = 2;  // unsigned integer >= 0
    string c = "hello";
    bool d=  false;
    address e = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    function hello() public pure returns (string memory){
        //local variables
        string memory message = "Hello World";
        return message;
    }
}