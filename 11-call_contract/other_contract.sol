// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract OtherContract {
    uint256 private _x = 0;
    event Log(uint amount, uint gas);

     function getBalance() view public returns(uint) {
        return address(this).balance;
    }
    function setX(uint256 x) external payable{
        _x = x;
        // 如果转入ETH，则释放Log事件
        if(msg.value > 0){
            emit Log(msg.value, gasleft());
        }
    }
     function getX() external view returns(uint x){
        x = _x;
    }
}

contract callContract {
    function callSetX(address _address, uint256 x) external {
        OtherContract(_address).setX(x);
    }
    function callGetX(OtherContract _address) external view returns(uint x) {
        x = _address.getX();
    }
    // 第二种方式
    function callGetX2(address _address) external view returns(uint x) {
        OtherContract result = OtherContract(_address);
        x = result.getX();
    }
    function setXtransferEth(address _address, uint x) payable external {
        OtherContract(_address).setX{value:msg.value}(x);
    } 
}