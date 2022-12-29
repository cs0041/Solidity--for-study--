// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;
contract MappedStructsWithIndex {

  struct EntityStruct {
    uint entityData;
    bool isEntity;
  }

  mapping(address => EntityStruct) public entityStructs;
  address[] public entityList;
  
  function newEntity(address entityAddress, uint entityData) public returns(uint rowNumber) {
    if(isEntity(entityAddress)) revert();
    entityStructs[entityAddress].entityData = entityData;
    entityStructs[entityAddress].isEntity = true;
    entityList.push(entityAddress);
    return getEntityCount() - 1;
  }

  function updateEntity(address entityAddress, uint entityData) public returns(bool success) {
    if(!isEntity(entityAddress)) revert();
    entityStructs[entityAddress].entityData = entityData;
    return true;
  }

  function isEntity(address entityAddress) public view returns(bool isIndeed) {
      return entityStructs[entityAddress].isEntity;
  }

  function getEntityCount() public view returns(uint entityCount) {
    return entityList.length;
  }
}

// solve problems
// All mapping values ​​have default values. There must be a way to make each mapping differentiate
// can't know all member in mapping 

// still Bad (new Bad)
// can't delete member in array entityList