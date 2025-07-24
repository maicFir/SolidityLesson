// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract TipJar {
    address public owner;
    constructor() {
        owner = msg.sender;
    }
    modifier onlyowner() {
        require(msg.sender == owner, "you are not winer");
        _;
    }
    function tip() public payable {
        require(msg.value > 0, "you should send tip to use this function");
    }

    function withdraw() public onlyowner {
        uint256 contractBlance = address(this).balance;
         require(contractBlance > 0, "There are no tips to withdraw");
         payable(owner).transfer(contractBlance);
    }
    function getBalance() public onlyowner view returns (uint256) {
        return address(this).balance;
    }
}