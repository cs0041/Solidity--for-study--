// SPDX-License-Identifier: MIT
pragma solidity =0.6.0;


contract OverandUnderFlow  {  
    
    uint256 n = 0;

    function add() public returns (uint256){
        n = n + 1;
        return n;
    }

    function subtract() public returns (uint256){
        n = n - 1;
        return n;
    }

}

import "./SafeMath.sol";
contract AddSafemath  {  
    using SafeMath for uint256;
    
    uint256 n = 0;

    function add() public returns (uint256){
        n = n.add(1);
        return n;
    }

    function subtract() public returns (uint256){
        n = n.sub(1);
        return n;
    }

}