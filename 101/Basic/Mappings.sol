// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

contract Mapping {

    mapping(address => uint256) balance;

    function addBalance(uint256 _toAdd) public {
        balance[msg.sender] += _toAdd;
    }

    function getBalance() public view returns (uint256){
        return balance[msg.sender];
    }
}