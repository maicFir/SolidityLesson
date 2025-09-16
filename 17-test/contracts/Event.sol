// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;



contract Event {
    event Log(address indexed sender, string msg, uint256 value);
  
    function test(string memory _name) public payable  {
        emit Log(msg.sender, _name, msg.value);
    }
    function setNumber(uint256 num) public pure returns(uint256) {
        require(num > 10, "num than 10");
        return num;
    }
}