// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;


library Util {
    function getName(string memory name) internal pure returns (string memory) {
       return name;
    }
}


contract A {
    string name = "Maic";

    function getUserName () view public returns(string memory) {
        return Util.getName(name);
    }
}