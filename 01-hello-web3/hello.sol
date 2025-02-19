// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract HelloWeb3 {
    string public _name = "hello solidity,this is my first project.";

    /*
        值类型： 布尔型，整数型
        引用类型：数组，结构体
        映射类型：键值的数据结构，哈希表


        int bool uint string

        int[] unit[] struct enum

        mapping

        function fnName() [internal/private/public/external/] [pure/view/payable] returns(int/uint) {}

        pure/view 不改变链上状态，不消耗gas
    */
   bool public  _is_first = true;
   int public _num_1 = -1; // 负整数
   uint public  _num_2 = 1; // 正整数
   uint256 public  _num_3 = 201233;
   uint256 public  _num_5 = 7 % 5;
   int public  _num_4 = _num_1 + 1;

   int private _num_6 = 10;

   // 地址类型
   address public _address_1 = 0x6c85e349A70791e95fD6D9D5e066C6Ec136E0a92;
   // payable可查询余额
   address payable public _address_2 = payable(_address_1);
   uint256 public balance = _address_2.balance;

   // 长字节数组
   bytes32 public _byte32 = "aello";
    
   bytes1 public _byte1 = _byte32[0];
    
   // 枚举

   enum Status {fail, success}

    // Status 申明一个n_status
   Status n_status = Status.success;
   // enum 显示转换unit
    uint public _status_1 = uint(n_status);
    int internal _interal = 1;
    int private   _private_num = 10;
    // init external  _external_num = 5;

   /**
       [ external、internal、public、private ] [pure view payable]

       public 内部和外部都可以访问
       private 只能从合约内部访问，继承的合约不能使用
       interval 只能从合约内部访问，继承的合约可以用
       external 只能从合约外部访问

       pure 不能访问合约变量
       view 可以访问合约变量
       payable
   **/
    function add() external {
    _num_1=_num_1+3;
    }
 
    function addPure(uint256 number) external pure returns (uint256 new_number) {
        // 不能访问合约变量
        new_number+=number + 1;
      
    }


    function addView() external view returns (uint256 new_number_2) {
        // 可以访问合约变量
        new_number_2 = _num_3 + 1;
    }
    // internal 申明的函数, 不能直接调用
     function minutes2 () internal   {
        _num_1 = _num_1 + 1;
        _num_6 = _num_6 + 1;
    }
    function minutes3() private  {
        _num_1 = _num_1 + 2;
    }

    // external的函数 能调用内部的合约函数minutes2
    function minutes2_call() external {
       minutes2();
       minutes3();
    }
    function minutesPayable() external payable returns (uint256 currentBalance) {
        minutes2();
        currentBalance = address(this).balance;
    }
    
    // returns 返回类型
    function return_numbe2 () public view returns (int _number, bool _bool) {
        return (_num_4, true);
    }
    
    // 赋值
    function returnName() public pure returns (uint256 _number, bool _bool, uint256[3] memory _array) {
        _number = 2;
        _bool = false;
        _array = [uint256(3),2,1];
    }
    function returnName2() public pure returns (int _number, bool _bool) {
        return (1, true);
    }
    // 解构
    function readReturnName() public pure  {
        uint256 _number;
        bool _bool;
        uint256[3] memory _array;
        (_number, _bool, _array) = returnName();
    }

}