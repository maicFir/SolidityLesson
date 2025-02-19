// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Parent {
    mapping (address => uint) public  _blance;


    // 通过将函数标记为 virtual，您允许后续的合约通过继承来修改该函数的行为
    function setBalance(address _address, uint _value) public virtual {
        _blance[_address] = _value;
    }
}

contract inheri is Parent {
  function setBalance(address _address, uint _value) public override  {
        _blance[_address] = _value + 10;
    }
}

contract Animal {
    event Name(string _name);
    function getCat() public virtual {
        emit Name("cat");
    }
    function getDog() public virtual {
        emit Name("Dog");
    }
}

contract isCat is Animal {
    function getCat() public virtual  override  {
        emit Name("Padal");
    }
}
abstract contract Base {
    string public _name = "Base";
    function getName() public  view virtual returns(string memory);
}

contract BaseImp is Base {
    // view可以访问合约变量，如果是pure则不能访问合约变量
    function getName() public view override returns(string memory) {
        return _name;
    }
}

