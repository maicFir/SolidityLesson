// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.4.0
pragma solidity ^0.8.28;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable {
    // 兼容之前的构造函数，支持可选的初始mint
    constructor(
        address recipient
    ) ERC20("Elen", "Elen_MTK") Ownable(msg.sender) {
        // 如果提供了recipient地址且不是零地址，则进行初始mint
        if (recipient != address(0)) {
            _mint(recipient, 10000000 * 10 ** decimals());
        }
        // 如果recipient是零地址，则不进行初始mint，完全手动控制
    }

    // // 重载构造函数：无参数版本，完全手动mint
    // // 默认构造函数，允许在部署时不传任何参数，由部署者后续手动mint
    // constructor() ERC20("Elen", "Elen_MTK") Ownable(msg.sender) {
    //     // 不进行任何初始mint
    // }

    // 只有合约owner可以调用的mint方法
    function mint(address recipient, uint256 amount) public onlyOwner {
        _mint(recipient, amount);
    }

    // 可选：添加批量mint方法
    function batchMint(
        address[] calldata recipients,
        uint256[] calldata amounts
    ) public onlyOwner {
        require(recipients.length == amounts.length, "Arrays length mismatch");
        for (uint256 i = 0; i < recipients.length; i++) {
            _mint(recipients[i], amounts[i]);
        }
    }
}
