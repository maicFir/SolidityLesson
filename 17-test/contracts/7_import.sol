// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.28;

contract ImportExample {
    uint public age = 10;
    string private name = "Tom";

    function getAge() public view returns(uint) {
        return age;
    }
    function getName() public view returns(string memory) {
        return name;
    }
}