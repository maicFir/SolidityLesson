// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Error {
    function yul(uint256 x) public pure {
        assembly {
            if gt(x, 10) {
                // 写入错误字符串到内存
                // "x must be <= 10" in hex (ASCII) = 0x78206d757374206265203c3d203130
                // 即 "x must be <= 10"，共 15 字节
                mstore(0x00, 0x78206d757374206265203c3d20313000000000000000000000000000000000)

                // revert(offset, size)
                // offset = 0x00, size = 15 bytes
                revert(0x00, 15)
            }
        }
    }
}
