// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

contract Event {


    mapping(address => uint256) balance;

    // indexed limit only 3 parameters per function
    // indexed use for query data from blockchain
    event balanceAdded(uint amount, address indexed depositedTo);


    function addBalance(uint256 _toAdd) public  {
        balance[msg.sender] += _toAdd;
        emit balanceAdded(_toAdd,msg.sender);
    }
}