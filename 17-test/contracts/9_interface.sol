// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.28;

interface User {
    function setName(string memory _name) external;
    function getName() external view returns(string memory);
}

contract newUser is User {
    string private name;

    function setName(string memory _name) public override  {
        name = _name;
    }
    function getName() public override  view returns(string memory) {
        return name;
    }
}