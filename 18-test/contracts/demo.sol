// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract A {
    // 申明name变量为public
     string public name = "Tom";
     uint private age = 18;
     string public hobby = "basketball";

      function add(uint a, uint b) public pure returns(uint) {
         return a + b;
      }
     // 申明getName为public
     function getName() public view returns(string memory) {
        return name;
     }

     function setAge (uint _age) public {
      age = _age;
     }

     function getAge() private  view returns(uint) {
       return age;
     }

     function getPrivateAge () public view returns(uint) {
        return getAge();
     }
     function setHobby(string memory _hobby) internal {
         hobby = _hobby;
     }

     function getHobby() public view returns(string memory) {
       return hobby;
     }
     function sum (uint a, uint b) internal pure returns(uint) {
        return a + b;
     }
   function foo(uint x) external pure returns(uint) {
        return x * 2;
    }
     function bar(uint y) public view returns(uint) {
        // return foo(y); // ❌ 错误
        return this.foo(y); // ✅ 只能这样调用
    }

}

contract B is A {
   uint public num = 0;
   function getViewParent() public view {
      // 子类访问父类public方法
      this.getName();
      this.getHobby();
      this.foo(2);
   }
   function setParentHobby(string memory _hoddy) public {
      setHobby(_hoddy);
   }
   function callSum(uint a, uint b) public {
      num = sum(a, b);
   }
}