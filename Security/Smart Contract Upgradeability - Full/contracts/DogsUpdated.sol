pragma solidity =0.5.2;

import "./Dogs.sol";

contract DogsUpdated is Dogs {

  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  constructor() public {
    initialize(msg.sender);
  }

  function initialize(address _owner) public {
    require(!_initialized);
    owner = _owner;
    _initialized = true;
  }

   function getNumberOfDogs() public view returns(uint256) {
    return _uintStorage["Dogs"];
  }
  function setNumberOfDogs(uint256 toSet) public onlyOwner  {
    _uintStorage["Dogs"] = toSet;
  }
}