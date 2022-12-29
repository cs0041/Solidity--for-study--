// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;
contract mappedWithUnorderedIndexAndDelete {

  struct EntityStruct {
    uint entityData;
    //more data
    uint listPointer; //0
  }

  mapping(address => EntityStruct) public entityStructs;
  address[] public entityList;

  function isEntity(address entityAddress) public view returns(bool isIndeed) {
    if(entityList.length == 0) return false;
    return (entityList[entityStructs[entityAddress].listPointer] == entityAddress);
  }

  function getEntityCount() public view returns(uint entityCount) {
    return entityList.length;
  }

  function newEntity(address entityAddress, uint entityData) public returns(bool success) {
    if(isEntity(entityAddress)) revert();
    entityStructs[entityAddress].entityData = entityData;
    entityList.push(entityAddress);
    entityStructs[entityAddress].listPointer = entityList.length - 1;
    return true;
  }

  function updateEntity(address entityAddress, uint entityData) public returns(bool success) {
    if(!isEntity(entityAddress)) revert();
    entityStructs[entityAddress].entityData = entityData;
    return true;
  }
  
  // Concept ::: Replace value you want to delete with the last value in the array, then pop the last array
  // [ADDRESS1, ADDRESS2, ADDRESS3, ADDRESS4]
  // Delete ADDRESS2
  // Replace value you want to delete with the last value in the array
  // [ADDRESS1, ADDRESS4, ADDRESS3, ADDRESS4]
  // then pop the last array
  // [ADDRESS1, ADDRESS4, ADDRESS3]  
  function deleteEntity(address entityAddress) public returns(bool success) {
    if(!isEntity(entityAddress)) revert();
    uint rowToDelete = entityStructs[entityAddress].listPointer; // = 1
    address keyToMove   = entityList[entityList.length-1]; //save last member address
    entityList[rowToDelete] = keyToMove;
    entityStructs[keyToMove].listPointer = rowToDelete; //= 2
    entityList.pop();
    delete entityStructs[entityAddress];
    return true;
  }

}

// solve problems
// can't delete member in array entityList
