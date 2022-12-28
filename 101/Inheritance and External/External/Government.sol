// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

contract Government {
    struct Transaction {
        address from;
        address to;
        uint amount;
        uint txId;
    }

    Transaction[] transactionLog;

    function addTransaction(address _from,address _to,uint amount) external payable  {
        transactionLog.push(Transaction(_from,_to,amount,transactionLog.length));
    }

    function getTransaction(uint _index) public view returns (Transaction memory) {
        return transactionLog[_index];
    }

    function getETHBalance() public view returns (uint256) {
        return address(this).balance;
    }

}