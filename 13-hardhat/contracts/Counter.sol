// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "hardhat/console.sol";

contract Counter {
    
    uint counter;

    struct userStatus {
        string name;
        string age;
    }
    mapping (string => uint256) private numObj;
    mapping (address => userStatus) private user;

     constructor() {
        counter = 0;
    }

    function createUser(string memory name, string memory age) public {
        user[msg.sender].name = name;
        user[msg.sender].age = age;
    }

    function getUser() public view returns(string memory, string memory) {
        return (user[msg.sender].name, user[msg.sender].age);
    }

  
    function favNum(string memory a, uint256 b) public {
        numObj[a] = b;
    }
    function getNum(string memory a) public view returns(uint256) {
        return numObj[a];
    }
    function add() public {
        counter+=1;
        console.log("counter is %s", counter);

    }
    function get() public view returns(uint) {
        return counter;
    }
}

contract Token is ERC20 {
   constructor(uint256 initialSupply) ERC20("Token Name", "Token Symbol") {
    _mint(msg.sender, initialSupply);
  }
}

