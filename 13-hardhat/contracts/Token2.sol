// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;


contract testUnitsGas {
    uint z1;
    function add_high_gas(uint x, uint y) public {
        z1 = x + y;
    }
    uint z2;
    function add_less_gas(uint x, uint y) public  {
        unchecked {
            z2 = x + y;
        }
    }  
    function testTrasfer(address payable x) public {
       address myAddress = address(this);
       if (x.balance < 10 && myAddress.balance >= 10) {
           x.transfer(10);
       }
    }
      function sayHi() public pure returns  (uint) {
        return 10;
        }
}

contract HelloCreator {
    uint public x;
    testUnitsGas public h;

    function createHello() public returns (address) {
        h = new testUnitsGas();
        return address(h);
  }
}
