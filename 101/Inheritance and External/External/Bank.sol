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

interface GovermentInterface {
    function addTransaction(address _from,address _to,uint amount) external payable;
}


contract Bank is Ownable  {

    mapping(address => uint256) balance;

    GovermentInterface govermentInterface = GovermentInterface(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);

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

    function transfer(address recipient,uint256 amount) public  {
        require(balance[msg.sender] >= amount,"balance sender must >= amount");
        require(msg.sender != recipient,"can't send to ourself");

        uint256 previpousSenderBalance = balance[msg.sender];

        _transfer(msg.sender, recipient, amount);

        govermentInterface.addTransaction{value: 1 ether}(msg.sender, recipient, amount);

        assert(balance[msg.sender] == previpousSenderBalance - amount);
    }

    function _transfer(address from,address to, uint256 amount) private  {
        balance[from] -= amount;
        balance[to] += amount;
    }
}