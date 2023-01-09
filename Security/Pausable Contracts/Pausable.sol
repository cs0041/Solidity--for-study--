//SPDX-License-Identifier: MIT
pragma solidity =0.8.17;


contract Pause  {
    
    mapping(address => uint256) balances;
    bool private _paused;
    address private owner;

    constructor () {
        owner = msg.sender;
        _paused = false;
    }

    modifier onlyOwner() {
        require(msg.sender == owner,"only owner can call");
        _;
    }

    // Allow to execute when contract is not paused
    modifier whenNotPaused() {
        require(_paused == false,"contract muse not paused");
        _;
    }

    modifier whenPaused() {
        require(_paused == true,"contract muse paused");
        _;
    }



    function pause() public onlyOwner whenNotPaused {
        _paused = true;
    }
    function unPause() public onlyOwner whenPaused {
        _paused = false;
    }

    function withdrawAll() public whenNotPaused {
        balances[msg.sender] =0;
    }

    function emergencyWithdrawl() public onlyOwner whenPaused {
        // withdrawal to owner
    }

}