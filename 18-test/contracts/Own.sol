// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract Own {
 // 申明了一个owner地址
  address public owner;

  constructor() {
    // 部署Own这个合约时所属钱包的地址
    owner = msg.sender;
  }
  receive() external payable { }
//   fallback() external payable { }

  // 获取由哪个钱包部署智能合约的钱包地址
  function getOwner() public view returns (address) {
    return owner;
  }
  // 获取部署这个智能合约的地址
  function getContractAddress() public view returns (address) {
    return address(this);
  }
  // 获取钱包与智能合约交互的那个地址
  function getSenderAddress() public view returns(address) {
    return msg.sender;
  }
  // 获取当前交互的钱包地址
  function getSenderAddressBalance() public view returns(uint) {
    return msg.sender.balance;
  }
  // 获取Sender钱包地址的余额【与智能合约交互的钱包地址，或者部署当前智能合约的钱包地址】
  function getSenderAddressBalance(address _address) public view returns(uint) {
    return _address.balance;
  }
  // 查询智能合约的余额地址
  function getContractAddressBalance() public view returns(uint) {
        return address(this).balance;
  }
  // 根据输入地址查询余额
  function getAddressBalance(address _address) public view returns(uint) {
    return _address.balance;
  }
  function send(address payable  _address) public payable {
    // bool send = _address.send(msg.value);
    // require(send, "sender error");
    (bool succeess,) = _address.call{value: msg.value}("");
    require(succeess, "Failed to send Ether");
  }
}