// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Test {
    uint age = 100;

    function getAge () public view returns(uint) {
        return age;
    }

    // 只能在外部调用
    function getExAge() external view returns(uint) {
        return getAge();
    }

    function getPrivateAge() private view returns(uint) {
        return getAge();
    }

    
    function callFn () public view returns(uint) {
        return getAge();
    }
     function callFn2 () public view returns(uint) {
        return getPrivateAge();
    }
    
}