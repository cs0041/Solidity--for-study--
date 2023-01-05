// SPDX-License-Identifier: MIT

// Pattern for protect smart contract from re-entrancy attack
// Every function must be written in this pattern
// CHECKS-EFFECTS-INTERACTIONS Pattern

pragma solidity =0.8.17;

contract Reentrancy  {  
    mapping(address  => uint256) balance;

    function withdrawALL() public {
        // CHECKS
        require(balance[msg.sender] > 0); 
        uint256 toTransfer = balance[msg.sender];

        //EFFECTS
        balance[msg.sender] = 0; 

        //INTERACTIONS
        (bool success,) = msg.sender.call{value: toTransfer}("");  
        if(!success){
            balance[msg.sender] = toTransfer;
        }
    }

}