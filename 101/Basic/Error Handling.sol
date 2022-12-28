// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

contract ErrorHandling {

    // require -> check for valid condition
    //         -> check inputs
    //         -> revert
    // assert  -> test for internal error
    //         -> check invariant( condition that is always true at a particular point in code)
       
    mapping(address => uint256) balance;
    address owner;

    modifier onlyOwner {
        require(msg.sender == owner,"only owner can call");
        _; // run code in function
    }

    modifier costs(uint256 price) {
        require(msg.value >= price,"value must >= price");
        _; // run code in function
    }

    constructor () {
        owner = msg.sender;
    }

    function addBalance(uint256 _toAdd) public onlyOwner  {
        balance[msg.sender] += _toAdd;
    }

    function getBalance() public view returns (uint256){
        return balance[msg.sender];
    }

    function transfer(address recipient,uint256 amount) public costs(1) payable {
        require(balance[msg.sender] >= amount,"balance sender must >= amount");
        require(msg.sender != recipient,"can't send to ourself");

        uint256 previpousSenderBalance = balance[msg.sender];

        _transfer(msg.sender, recipient, amount);

        assert(balance[msg.sender] == previpousSenderBalance - amount);
    }

    function _transfer(address from,address to, uint256 amount) private  {
        balance[from] -= amount;
        balance[to] += amount;
    }
}