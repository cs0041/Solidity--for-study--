// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;



contract FallBack  {  
    
    receive() external payable{
        // call when no data and have send value
    }

    fallback() external payable{
        // call when no other function in conract matches
    }

}