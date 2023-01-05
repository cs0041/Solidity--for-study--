// SPDX-License-Identifier: MIT

// Calling external fucntions
// We are calling from Contract A -> Contract B

pragma solidity =0.8.17;

// Call
// Call -> ContractB.call()
// call is a low level function to interact with other contracts.
// This is the recommended method to use when you're just sending Ether via calling the fallback function.
// However it is not the recommend way to call existing functions.
// Few reasons why low-level call is not recommended
//  - Reverts are not bubbled up
//  - Type checks are bypassed
//  - Function existence checks are omitted

contract Receiver {
    event Received(address caller, uint amount, string message);

    fallback() external payable {
        emit Received(msg.sender, msg.value, "Fallback was called");
    }

    function foo(string memory _message, uint _x) public payable returns (uint) {
        emit Received(msg.sender, msg.value, _message);

        return _x + 1;
    }
}

contract ExternalCall  {  
     event Response(bool success, bytes data);

    function testCallFoo(address payable _addr) public payable {
        // You can send ether and specify a custom gas amount
        (bool success, bytes memory data) = _addr.call{value: msg.value, gas: 5000}(
            abi.encodeWithSignature("foo(string,uint256)", "call foo", 123)
        );

        emit Response(success, data);
    }

    // Calling a function that does not exist triggers the fallback function.
    function testCallDoesNotExist(address payable _addr) public payable {
        (bool success, bytes memory data) = _addr.call{value: msg.value}(
            abi.encodeWithSignature("doesNotExist()")
        );

        emit Response(success, data);
    }
  

}

// CallCode
// ContractB.callcode()
// Call function in External Contract
// Using Contract A scope
// Throws no error if it fails
// Returns true/false

// Delegatecall
// Delegatecall -> ContractB.delegatecall()  *same callcode but fix bugs (good than callcode)
// Call function in External Contract 
// Using Contract A scope
// Throws no error if it fails
// Returns true/false

// delegatecall is a low level function similar to call.
// When contract A executes delegatecall to contract B, B's code is executed
// with contract A's storage, msg.sender and msg.value.


// NOTE: Deploy this contract first
contract B {
    // NOTE: storage layout must be the same as contract A
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) public payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract A {
    uint public num;
    address public sender;
    uint public value;

    function setVars(address _contract, uint _num) public payable {
        // A's storage is set, B is not modified.
        (bool success, bytes memory data) = _contract.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );
    }
}

// Most people use this.
// ContractB.fucntionABC()
// Call function in Contract B
// Using contract B scope
// will throw error if fucntionABC() throws