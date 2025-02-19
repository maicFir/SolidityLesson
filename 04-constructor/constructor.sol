// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Owner {
    address public owner;

       mapping(address => uint256) public _balances;
    // 修饰器
    modifier onlyOwner() {
        require(msg.sender == owner); // 检查调用者是否为owner地址
        _; // 如果是的话，继续运行函数主体；否则报错并revert交易
    }
    constructor(address initOwner) {
        owner = initOwner;
        _balances[initOwner] = 10000000;
    }
    function changeAddress(address _newAddress) external  onlyOwner {
       owner = _newAddress;
    }
    // 定义Transfer函数，记录transfer交易转账地址，接收地址和转账数量
    event Transfer(address indexed from, address indexed to, uint256 value);

    function _transfer(address from, address to, uint256 amount) external {
        // 检查是否有余额
        // require(_balances[from] >= amount, "Insufficient balance"); 

        _balances[from] -=  amount; // from地址减去转账数量
        _balances[to] += amount; // to地址加上转账数量

        // 释放事件
      emit Transfer(from, to, amount);
    }
   
}

