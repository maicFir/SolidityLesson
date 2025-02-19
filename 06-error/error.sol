// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

error TransferNotOwner();

contract Errors {
    mapping (uint => address) private _own;

    function transformOwn(uint id, address new_own) public {
        require(_own[id] == msg.sender, "Transfer Not Owner");
        _own[id] = new_own;
    }

    function transferOwner1(uint256 tokenId, address new_own) public {
        if (_own[tokenId] != msg.sender) {
            revert TransferNotOwner();
        }
        _own[tokenId] = new_own;
    }
    function transferOwner3(uint256 tokenId, address new_own) public {
        // 使用assert
        assert(_own[tokenId] == msg.sender);
        _own[tokenId] = new_own;
    }
       function getOwner(uint id) public view returns (address) {
        return _own[id];
    }
}