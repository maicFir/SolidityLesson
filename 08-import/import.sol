// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Yeyo} from  "./yeyo.sol";

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Import {
    Yeyo _say = new Yeyo();
    using Address for address;
    function sayhello() external {
      _say.hello();
      
    }
    function getAddress(address _address) public view  {
        _address.balance;
    }
}