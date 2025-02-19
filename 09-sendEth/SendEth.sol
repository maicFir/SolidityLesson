// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

error SendFailed();

error callFialed();


contract sendEth {
    constructor() payable  {}
    // 接收eth时被触发
    receive() external payable { }

    // transfer
    function transferEth(address payable _to, uint256 _amount) external payable {
        _to.transfer(_amount);
    }

    function sendETH(address payable _to, uint256 _amount) external payable  {
        bool success = _to.send(_amount);
        if (!success) {
            // 抛出错误
            revert SendFailed();
        }
    }
    function callETH(address payable _to, uint256 _amount) external payable  {
        // ,占位剩下的返回值
        (bool success,) = _to.call{value: _amount}("");
         if(!success){
            revert callFialed();
        }
    }

}
 contract ReceiveEth {
    event Log(uint amount, uint gas);
    receive() external payable {
        emit Log(msg.value, gasleft());
    }
    function getBlance() view public returns(uint) {
        return address(this).balance;
    }
 }