// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

contract IfElse {

    function test() public view  returns (string memory){
        if(msg.sender == 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4){
            return "YES";
        }else{
            return "NO";
        }
    }


}