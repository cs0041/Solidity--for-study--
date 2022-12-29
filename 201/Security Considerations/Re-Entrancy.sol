// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

// Pattern for protect smart contract from re-entrancy attack
// Every function must be written in this pattern
// [CHECKS --- EFFECTS (chaining state) --- INTERACTIONS]


// ***Send*** and ***transfer***  -> can use only 2300 gas  
// Good - modern and use only 2300 gas can protect smart contract from re-entrancy attack because the gas is not enough to call  function again
// Bad  - absolutely do not use. If future improvements in gas in call fallback are use more than 2300 gas , when call send or transfer in contract will fail
//      - and If future improvements in gas in call fallback are use less than 2300 gas and enough gas left to re-entrancy attack
//***msg.sender.call.value(amount)("")*** -> can use infinite gas  
// Bad  - can use infinite gas it meant can re-entrancy attack 

//***msg.sender.call{value: toTransfer}("")***  
// Good - modern and  mostly used now

contract Reentrancy  {  
    mapping(address  => uint256) balance;

    function withdraw() public {
        require(balance[msg.sender] > 0); // CHECKS
        uint256 toTransfer = balance[msg.sender];
        balance[msg.sender] = 0; // EFFECTS (chaining state)
        (bool success,) = msg.sender.call{value: toTransfer}("");  // INTERACTIONS 
        if(!success){
            balance[msg.sender] = toTransfer;
        }
    }

}