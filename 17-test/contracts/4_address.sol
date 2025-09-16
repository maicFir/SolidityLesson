// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.28;


contract AddressExample {
    address public owen;
    constructor() {
        // 当部署合约完成时，这个地址就不会变化了，除非重新部署,创建智能合约地址
        owen = msg.sender;
    }
    // 获取与合约交互的用户地址
    function getAddress () public view returns(address) {
        return msg.sender;
    }
    // 获取AddressExample这个合约地址
    function getContractAddress() public view returns(address) {
        return  address(this);
    }

    // 获取部署合约的地址
    function getOwnAddress () external  view returns (address) {
        return owen;
    }

    function getBlanace() external view returns(uint,uint,uint) {
        uint contractBlance = address(this).balance;
        uint senderBlanace = msg.sender.balance;
        uint owenBlance = owen.balance;
        return (contractBlance, senderBlanace, owenBlance);
    }
}