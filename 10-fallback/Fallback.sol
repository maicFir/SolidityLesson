// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Fallback {
    event receiveCalled(address Sender, uint Value);
    event failbackCalled(address Sender, uint Value, bytes data);
    receive() external payable { 
        emit receiveCalled(msg.sender, msg.value);
    }
    // fallback
    fallback() external payable {
        emit failbackCalled(msg.sender, msg.value, msg.data);
    }
}