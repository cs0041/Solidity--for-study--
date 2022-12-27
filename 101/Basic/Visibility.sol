// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

contract Visibility {

    // Public -> everyone can access 

    // Private -> only within contract can access
    // help -> 1. clean code
    //         2. reuse code

    // External -> only other contract can access

    // Internal -> same private "only within contract can access" but with a little extra
    // another contract whose inheritance will can access
    
     mapping(address => uint256) balance;

    function addBalance(uint256 _toAdd) public {
        balance[msg.sender] += _toAdd;
    }

    function getBalance() public view returns (uint256){
        return balance[msg.sender];
    }

    function transfer(address recipient,uint amount) public {
        _transfer(msg.sender, recipient, amount);
    }

    function _transfer(address from,address to, uint amount) private {
        balance[from] -= amount;
        balance[to] += amount;
    }
}