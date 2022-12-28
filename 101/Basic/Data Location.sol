// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

contract DataLocation  {

    // storage - persitant data storage
    // memory - temporary data storage
    // calldata - similar to memory, but read-only 

    // state variables will be automatic storage - persitant data storage
    mapping(uint => User) users;

    struct User{
        uint id;
        uint balance;
    }

    function addUser(uint id, uint balance) public {
        users[id] = User(id, balance);
    }

    function updateBalance(uint id, uint balance,string calldata text, string memory changeText) public returns (string calldata,string memory) {
         // User memory user = users[id]; // data will lost because it is stored in temporary data storage
         User storage user = users[id];  // it will pointer to persistent data storage and can change data in storage
         user.balance = balance;
         changeText = "hi";  // changeText -> temporary data storage can reand/change
                             // text -> temporary data storage can read-only 
         return (text,changeText);
    }

    function getBalance(uint id) view public returns (uint) {
        return users[id].balance;
    }

}