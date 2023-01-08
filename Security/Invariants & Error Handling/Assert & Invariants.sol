// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

// assert use only true condition invariants

contract Bank{
    
    mapping  (address => uint256)  balance;
    uint256 totalSupply;
    
    function deposit() public payable {
        balance[msg.sender] += msg.value;
        totalSupply += msg.value;
        assert(address(this).balance >= totalSupply);
    }

    function withdrawAll() public{
        require(balance[msg.sender] > 0);
        uint256 amountToWithdraw = balance[msg.sender];
        balance[msg.sender] = 0;
        payable(msg.sender).transfer(amountToWithdraw);
        assert(balance[msg.sender] ==0);
    }
    
    
     
    
}
