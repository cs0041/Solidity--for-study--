// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

contract Struct {

    struct Person {
        uint256 age;
        string name;
    }

    Person[] people;

    function addPerson(uint256 _age, string memory _name)public {
        Person memory newPerson = Person( _age,_name );
        people.push(newPerson);
    }

    function getPerson(uint256 _index) public view returns (uint256,string memory)  {
       return (people[_index].age,people[_index].name);
    }
}