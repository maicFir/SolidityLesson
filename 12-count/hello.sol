// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Counter {
    uint counter;
    constructor() {
        counter = 0;
    }
    function setCounter() public {
        counter+=10;
    }
    function getCounter () public  view returns (uint) {
        return counter;
    }
} 

