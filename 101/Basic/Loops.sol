// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

contract Loops {

    function While(uint number) public pure  returns (uint){
       uint i = 0;
       while (i < 10){
        number++;
        i++;
       }
       return number;
    }

    function For(uint number) public pure  returns (uint){
       for (uint i = 0; i < 10; i++){
        number++;
       }
       return number;
    }

}