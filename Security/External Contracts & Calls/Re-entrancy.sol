// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

contract Reentrancy  {  
    mapping(address  => uint256) balance;

    function withdraw() public {
        require(balance[msg.sender] > 0); 
        uint256 toTransfer = balance[msg.sender];
        (bool success,) = msg.sender.call{value: toTransfer}("");  
        balance[msg.sender] = 0; 
        if(!success){
            balance[msg.sender] = toTransfer;
        }
    }

}