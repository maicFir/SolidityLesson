// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract WalletEther {
    address payable public owner;
    constructor() {
        owner = payable(msg.sender);
    }
    receive() external payable { }
    function sender(address payable _contractAddress) public payable {
        _contractAddress.transfer(msg.value);
    }
    // 从合约里提取一定数量的钱
    function withdraw(uint256 _amount) external  {
           require(msg.sender == owner, "caller is not owner");
           payable(msg.sender).transfer(_amount);
    }
    function getBalance() external  view returns(uint256) {
        return address(this).balance;
    }
    function getMsgSinderBalance() public view returns(uint) {
        return msg.sender.balance;
    }
}