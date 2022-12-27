// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

contract Array {

    //fix size of the array not have method push/pop
    uint256[4] number_fix_size = [1,2,3];
    
    uint256[] number_dynamic_size;

    function addNumberForDynamic(uint256 _number) public {
        number_dynamic_size.push(_number);
    } 

    function addNumberForFixSize(uint256 _number) public {
        number_fix_size[3]=_number;
    }

    function getNumber(uint256 _id) public view returns(uint256 a,uint256 b){
        a = number_dynamic_size[_id];
        b = number_fix_size[_id];
    }

    function getNumbersFixSize() public view returns(uint[4] memory){
       return number_fix_size;
    }

    function getNumbersDynamicSize() public view returns(uint[] memory){
       return number_dynamic_size;
    }


}