// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.28;

contract Receiver {
    event Received(address caller, uint amount, string message);

    // 合约账户接受
    receive() external payable {
        emit Received(msg.sender, msg.value, "Receive called");
     }
     fallback() external payable {
           emit Received(msg.sender, msg.value, "fallback called");
      }

     function getAddress() public view returns(address) {
        return address(this);
     }

     function getBlance() public view returns(uint) {
        return address(this).balance;
     }
}

contract Called {
    Receiver reciver;
    event Response(bool success, bytes data);
    constructor() {
        reciver = new Receiver();
    }
    function testCall(address payable _address) public payable  {
        // 当call{}(abc)有参数时，则会调用fallback
        (bool success, bytes memory data) = _address.call{value: msg.value}("");
        emit Response(success, data);
    }
    // 获取合约地址
    function getContractAddress() public view returns(address) {
        return reciver.getAddress();
    }
    // 获取余额
    function getContractBalance() public view returns(uint) {
        return reciver.getBlance();
    }
}