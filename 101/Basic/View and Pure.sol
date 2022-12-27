// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

contract ViewPure {

    //state variables
    string message = "hello";


    //pure -> only use local variables must don't access state variables
    function pureMessage(string memory _new) public pure returns (string memory){
        //local variables
        string memory non_state_variables = "value";
        non_state_variables = _new;
        return non_state_variables;
    }

    //view -> read only and can access state variables
    function getMessage() public view  returns (string memory){
        return message;
    }

    //not view and pure -> read and change state variables
    function setMessage(string memory _message) public  returns (string memory){
        message = _message;
        return message;
    }
}