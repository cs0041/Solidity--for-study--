// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

contract simpleList {

  struct EntityStruct {
    address entityAddress;
    uint entityData;
  }

  EntityStruct[] public entityStructs;

  function newEntity(address entityAddress, uint entityData) public returns(EntityStruct memory) {
    EntityStruct memory newEntity;
    newEntity.entityAddress = entityAddress;
    newEntity.entityData    = entityData;
    entityStructs.push(newEntity);
    return entityStructs[entityStructs.length - 1];
  }

  function getEntityCount() public view returns(uint entityCount) {
    return entityStructs.length;
  }
}

// Good
// can know member in array 

// Bad
// hard to operation(updata,delete,access) data (must loop it bad take time and expensive gas)
// value in struct​​can be repeated ex. same address
