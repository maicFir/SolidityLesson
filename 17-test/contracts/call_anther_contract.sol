// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.28;

contract Salfer {
    uint public salfeCount;

    function getSalfeCount () external view returns(uint) {
        return salfeCount;
    }
    // setSalfeCount 只能外部调用
    function setSalfeCount (uint num) external {
        salfeCount = num;
    }
}

// 在一个合约里调用另外一个合约
contract OtherSalfer {
    Salfer newSalfter;
    constructor() {
        newSalfter = new Salfer();
    }
    function getSalfer() public view returns(uint) {
        return newSalfter.getSalfeCount();
    }
    // 
    function setSafer(uint num) external   {
        newSalfter.setSalfeCount(num);
    }
    function getSalferAddress () external  view returns(address) {
        return address(newSalfter);
    }
}