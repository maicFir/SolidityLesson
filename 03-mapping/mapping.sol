// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Mapping {
    // 常量
    uint256 private constant CONFIG_NUMBER = 10;
    // 可变的常量 可以在申明时初始化，也可以在constructor中初始化
    uint256 public immutable IMMUTABLE_NUM = 9999999999;

    uint256[] public _a;
    uint256[2] public _b = [7, 8];

    // key是uint,值是address
    mapping(uint256 => address) public new_address;
    // key是bytes32 值是address
    mapping(bytes32 => address) public symbol;

    function writeAddressMap(uint256 _key, address _value) public {
        new_address[_key] = _value;
    }

    constructor() {
        IMMUTABLE_NUM = set_immutable_num();
    }

    function wariteSymbolMap(string calldata _key, address _value) external {
        // 将_key通过abi.encodePacked变成bytes32
        bytes32 has_key = keccak256(abi.encodePacked(_key));
        symbol[has_key] = _value;
    }

    function getSymbol(bytes32 _key) public view returns (address) {
        return symbol[_key];
    }

    function set_immutable_num() public pure returns (uint256) {
        uint256 num = 10;
        return num;
    }

    // if条件
    function is_test(uint256 num) public pure returns (bool) {
        if (num == 0) {
            return false;
        } else {
            return true;
        }
    }

    // for循环
    function forTest() public pure returns (uint256) {
        uint256 num = 0;
        for (uint256 i = 0; i <= 10; i++) {
            num += i;
        }
        return num;
    }
    // while循环
    function forWhile() public pure returns(uint) {
        uint sum = 0;
        uint i =0;
        while (i <= 10) {
            sum+=i;
            i++;
       
        }
        return sum;
    }
    // 一个冒泡排序
    function bubbleSort(uint[] memory arr) public pure returns(uint[] memory) {
        for (uint i=1;i<arr.length;i++) {
            uint temp = arr[i];
            uint j = i;
            while ((j >=1) &&(temp < arr[j-1])) {
                arr[j] = arr[j-1];
                j--;
            }
            arr[j] = temp;
        }
        return arr;
    }

}
