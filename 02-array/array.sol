// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

/**
   数据存储有三类
   storage 默认存在链上这里，可以使用push，不能用于局部变量，只存储合约变化状态
   memory 参数和函数的临时变量，存储在内存中，不上链，不可添加使用push，只适用于形参
   calldata: 存储在内存中，不上链，calldata变量不可修改，一般用于函数的参数
*/
contract ArrayTest {
    // 合约级别变量
    uint256[] public _a = [1, 2, 8];

    int256 public number = 1;

    function fxStorage() public {
        uint256[] storage xStorage = _a;
        xStorage[0] = 100;
    }

    function setNumber() external {
        // memory 只能用于函数内部的变量，动态创建数组，且不能使用push
        uint256[] memory array1 = new uint256[](2);
        number = 10;
        array1[0] = 1;
        array1[1] = 2;
        _a.push(9);
        getNumber(array1);
    }

    function getA(uint256[] memory x) public pure returns (uint256[] memory) {
        return x;
    }

    function getNumber(uint256[] memory x)
        public
        pure
        returns (uint256[] memory)
    {
        return x;
    }

    // 局部变量,消耗gas低
    function foo() public pure returns (uint256) {
        uint256 x = 1;
        uint256 y = 2;
        uint256 z = x + y;
        return uint256(z);
    }

    function global()
        external
        view
        returns (
            address,
            uint256,
            bytes memory
        )
    {
        address sender = msg.sender;
        uint256 blockNum = block.number;
        // memory 临时变量
        bytes memory data = msg.data;
        return (sender, blockNum, data);
    }

    function weiUnit() external pure returns (uint256) {
        assert(1 wei == 1e0);
        assert(1 wei == 1);
        return 1 wei;
    }

    // 解构体
    struct Student {
        uint256 id;
        string name;
    }
    Student public student;

    function initStudent() external {
        student.id = 1;
        student.name = "Maic";
    }
    function initStudent2() external{
      student = Student({id: 1, name: "Tom"});
    }
}
