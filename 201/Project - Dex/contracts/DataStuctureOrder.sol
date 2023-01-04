// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

contract Order{

      enum Side {
        BUY,
        SELL
    }

    struct Order {
        uint256 id;
        address trader;
        Side side;
        bytes32 ticker;
        uint256 amount;
        uint256 price;
        uint256 filled;
    }

  //mapping(uint256 => Order) public payload;
  mapping(uint256 => uint256) public payload;
  mapping(uint256 => uint256) _nextNodeID;
  uint256 public listSize;
  uint8 constant GUARD = 0;
  uint256 public nodeID = 1;

  constructor()  {
    _nextNodeID[GUARD] = GUARD;
  }

  // function addStudent( uint256 score) public {
  //   require(score > 0,"must > 0");
  //   uint256 index = _findIndex(score);
  //   payload[nodeID] = score;
  //   _nextNodeID[nodeID] = _nextNodeID[index];
  //   _nextNodeID[index] = nodeID;
  //   listSize++;
  //   nodeID++;
  // }

   function addStudent( uint256 score, uint256 prevIndex) public {
    require(score > 0,"must > 0");
    require(_verifyIndex(prevIndex, score, _nextNodeID[prevIndex]));
    payload[nodeID] = score;
    _nextNodeID[nodeID] = _nextNodeID[prevIndex];
    _nextNodeID[prevIndex] = nodeID;
    listSize++;
     nodeID++;
  }

  // function removeStudent(uint256 index) public {
  //   // require(_nextNodeID[index] != 0,"_nextNodeID[index] != 0");
  //   uint256 prevStudent = _findPrevStudent(index);
  //   _nextNodeID[prevStudent] = _nextNodeID[index];
  //   // _nextNodeID[index] = address(0);
  //   // payload[index] = 0;
  //   listSize--;
  // }

  function removeStudent(uint256 index, uint256 prevIndex) public {
    require(_isPrevStudent(index, prevIndex));
    _nextNodeID[prevIndex] = _nextNodeID[index];
    listSize--;
  }

  function getData() public view returns(uint256[] memory) {
    uint256[] memory dataList = new uint256[](listSize);
    uint256 currentNodeID = _nextNodeID[GUARD];
    for(uint256 i = 0; i < listSize; ++i) {
      dataList[i] = payload[currentNodeID];
      currentNodeID = _nextNodeID[currentNodeID];
    }
    return dataList;
  }


  function _verifyIndex(uint256 prevStudent, uint256 newValue, uint256 nextStudent)
    internal
    view
    returns(bool)
  {
    return (prevStudent == GUARD || payload[prevStudent] >= newValue) && 
           (nextStudent == GUARD || newValue > payload[nextStudent]);
  }

  function _findIndex(uint256 newValue) public view returns(uint256) {
    uint256 currentNodeID = GUARD;
    while(true) {
      if(_verifyIndex(currentNodeID, newValue, _nextNodeID[currentNodeID]))
        return currentNodeID;
      currentNodeID = _nextNodeID[currentNodeID];
    }
    return 0;
  }

  function _isPrevStudent(uint256 student, uint256 prevStudent) internal view returns(bool) {
    return _nextNodeID[prevStudent] == student;
  }

  function _findPrevStudent(uint256 student) public view returns(uint256) {
    uint256 currentAddress = GUARD;
    while(_nextNodeID[currentAddress] != GUARD) {
      if(_isPrevStudent(student, currentAddress))
        return currentAddress;
      currentAddress = _nextNodeID[currentAddress];
    }
    revert("not exist");
  }
}  