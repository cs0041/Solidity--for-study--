// SPDX-License-Identifier: MIT

// Push vs Pull

// Push (Bad)
// Push funds to user

// Pull (Good)
// Let user pull out funds themselves

pragma solidity =0.8.17;

// Exnaoke of Push (Bad)
contract Push  {  

    function play() public payable {
        // GAME LOGIC

        if(win) {
            player.transfer(prize);
        }
    }
}

// Exnaoke of Pull (Good)
contract Pull  {  

    function play() public payable {
        // GAME LOGIC

        if(win) {
            prizes[player] = prize;
        }
    }

    function getPrize() public {
        uint256 prize = prizes[msg.sender];
        prizes[msg.sender] = 0;
        msg.sender.transfer(prize);
    }
}