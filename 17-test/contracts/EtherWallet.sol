// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract EtherWallet {
    address payable public owner;
    constructor() payable  {
        // 部署合约地址
        owner = payable(msg.sender);
    }
    receive() external payable { }
    function withdraw(uint256 _amount) external  {
        require(msg.sender == owner, "caller is not owner");
        payable(msg.sender).transfer(_amount);
    }
    function getBlance() external view returns(uint256) {
        return address(this).balance;
    }
}