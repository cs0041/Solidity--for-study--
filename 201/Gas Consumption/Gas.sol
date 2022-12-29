// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

contract Gas {

    uint[] storageArray; // [1,2,3]

    //Assign 2 types
    //Assgin by copy
    //Assgin by reference (pointer)

    // storage = memory  -> COPY
    // memory = storage  -> COPY

    //memory = memory -> REFERENCE
    //Local storage = storage -> REFERENCE

    function f(uint[] memory memoryArray) public {
        storageArray = memoryArray; //copy value memoryArray to storageArray (storage = memory  -> COPY)

        uint[] memory memoryArray2 = storageArray;  // copy value storageArray to memoryArray2 (memory = storage  -> COPY)
        uint[] storage pointerArray = storageArray; // create reference(pointer) to storageArray (Local storage = storage -> REFERENCE)

        pointerArray.push(7);

        uint[] memory memoryArray3 = memoryArray; // create reference(pointer) to memoryArray  (memory = memory -> REFERENCE)

    }

    // Assign
    //*storage* gas expensive > *memory or calldata*
    // *copy* gas expensive > *reference*
    // *memory* gas expensive > *calldata*

    //Event
    // *storing historical data in the blockchainuse* gas expensive > *event*

    //Function
    // *public* gas expensive > *external*


}