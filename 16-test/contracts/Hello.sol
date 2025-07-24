// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Hello {
    string public name = "Hello World";
    uint public count = 0;

    function increment() public {
        count++;
    }
    function desc() public {
        count--;
    }
    function get() public view returns (uint) {
        return count;
    }
}
