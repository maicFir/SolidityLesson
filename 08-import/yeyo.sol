// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Yeyo {
    event Log(string msg);
    function hello() public virtual  {
        emit Log("hello");
    }
}