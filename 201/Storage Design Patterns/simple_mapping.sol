// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;
contract mappingWithStruct {

  struct EntityStruct {
    uint entityData;
    bool isEntity;
  }

  mapping (address => EntityStruct) public entityStructs;

  function newEntity(address entityAddress, uint entityData) public returns(bool success) {
    if(isEntity(entityAddress)) revert(); 
    entityStructs[entityAddress].entityData = entityData;
    entityStructs[entityAddress].isEntity = true;
    return true;
  }
  
  function isEntity(address entityAddress) public view returns(bool isIndeed) {
    return entityStructs[entityAddress].isEntity;
  }

  function deleteEntity(address entityAddress) public returns(bool success) {
    if(!isEntity(entityAddress)) revert();
    entityStructs[entityAddress].isEntity = false;
    return true;
  }

  function updateEntity(address entityAddress, uint entityData) public returns(bool success) {
    if(!isEntity(entityAddress)) revert();
    entityStructs[entityAddress].entityData = entityData;
    return true;
  }
}


// Good
// can access data very fast
// key in mapping is unique 

// Bad
// All mapping values ​​have default values. There must be a way to make each mapping differentiate
// can't know all member in mapping 