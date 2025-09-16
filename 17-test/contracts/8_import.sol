// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.28;

// 引入另一个文件
import "./7_import.sol";

contract Test {
    ImportExample example = new ImportExample();

    function getAge () public view returns(uint) {
        return example.getAge();
    }

}