// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.28;

contract SendExample {
    // 从合约地址转
    function send(address payable to) public payable {
        // 从交互钱包地址向to目标地址转账，有返回，当返回false，证明失败
     bool isSend = to.send(msg.value);
     require(isSend, "send fail");
    }
    function trans(address payable to) public payable {
        // 没有返回
        to.transfer(msg.value);
    }
    function call(address payable to) public payable {
        // 有返回
        (bool isSend,) = to.call{value: msg.value}("");
        require(isSend, "call fail");
    }
}