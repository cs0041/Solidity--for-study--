// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

contract Payble {

    mapping(address => uint256) balance;
    address owner;

    event Deposit(uint amount, address indexed depositedTo);

    modifier onlyOwner {
        require(msg.sender == owner,"only owner can call");
        _; // run code in function
    }


    constructor () {
        owner = msg.sender;
    }

    function deposit() public payable  {
        balance[msg.sender] += msg.value;
        emit Deposit(msg.value,msg.sender);
    }

    function withdraw(uint256 amount) public {
        require(balance[msg.sender]>= amount,"balance user must >= amount withdraw");
        balance[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function getBalance() public view returns (uint256){
        return balance[msg.sender];
    }

  
}