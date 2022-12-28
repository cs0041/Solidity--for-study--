// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;
// import "./";

contract Ownable {
    address owner;

    modifier onlyOwner {
        require(msg.sender == owner,"only owner can call");
        _; // run code in function
    }

    constructor () {
        owner = msg.sender;
    }

}


contract Bank is Ownable  {

    mapping(address => uint256) balance;

    // indexed limit only 3 parameters per function
    // indexed use for query data from blockchain
    event Deposit(uint amount, address indexed depositedTo);


    function deposit() public payable  {
        balance[msg.sender] += msg.value;
        emit Deposit(msg.value,msg.sender);
    }

    function withdraw(uint256 amount) public onlyOwner{
        require(balance[msg.sender]>= amount,"balance user must >= amount withdraw");
        balance[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function getBalance() public view returns (uint256){
        return balance[msg.sender];
    }
}