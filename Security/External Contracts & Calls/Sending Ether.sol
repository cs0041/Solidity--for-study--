// SPDX-License-Identifier: MIT

// Sending Ether safely


// send (2300 gas, returns bool) -> payable(msg.sender).send(amount);
// Safe against re-entrency
// 2300 Gas Stipend

// transfer (2300 gas, throws error) ->  payable(msg.sender).transfer(amount);
// Safe against re-entrency
// 2300 Gas Stipend
// Sams as send() but with a built in require()  Revert on failure
// require(msg.sender.send(amount))

// call (forward all gas or set gas, returns bool) -> msg.sender.call{value: amount}("")
// Unlimited gas to fallback
// can re-entrancy attack

// Which method should you use?
// call in combination with re-entrancy guard is the recommended method to use after December 2019.

pragma solidity =0.8.17;

contract SendEther  {  

    mapping(address  => uint256) balance;

    function withdrawALL() public {
        payable(msg.sender).send(balance[msg.sender]);

        payable(msg.sender).transfer(balance[msg.sender]);

        msg.sender.call{value: balance[msg.sender]}("");
    }

}