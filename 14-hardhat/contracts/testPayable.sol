// SPDX-License-Identifier: MIT
pragma solidity 0.8;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract testPayable {
    
    event Received(address, uint);
    receive() external payable { 
        emit Received(msg.sender, msg.value);
    }
    constructor() payable {}
}
contract MyToken is ERC20 {
    constructor() ERC20("MyToken", "MTK") {}
}

contract Award {
    IERC20 immutable token;
    constructor(address t) {
       token = IERC20(t);
    }
    function sendAward(address user) public {
        token.transfer(user, 100);
    }
}
library Math {
    function max(uint256 a, uint256 b) external pure returns (uint256) {
        return a > b ? a : b;
    }

}

contract Back {
    using Math for uint;
    mapping (address => uint) public deposits;

    function callMax(uint x, uint y) public pure returns (uint) {
       return x.max(y);
    }
    function deposit() public payable {
        deposits[msg.sender] += msg.value;
    }
      function withdraw() public {
        uint d = deposits[msg.sender];
        deposits[msg.sender] = 0;

        (bool success, ) = msg.sender.call{value:  d}("");
        require(success, "Failed to send Ether");
    }
}