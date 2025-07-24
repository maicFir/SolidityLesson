pragma solidity ^0.8.20;

event HighestBidIncreased(address bidder, uint256 amount); // 定义事件

contract Purchase {
    address public seller;
    // 定义修饰器
    modifier onlySeller() {
        require(msg.sender == seller, "Only seller can call this function");
        _;
    }

    function buy() public payable onlySeller {
        // 购买商品
        // 购买商品
    }

    function sell(uint256 amount) public onlySeller {
        // 出售商品
        // 出售商品
    }
    function abort() public onlySeller {} // 取消交易

    function bid() public payable {
        // 出价
        emit HighestBidIncreased(msg.sender, msg.value); // 触发事件
    }
    function c(uint a, uint b) public pure returns (uint) {
        return a + b;
    }
    function d(uint a, uint b) public pure returns (uint) {
        unchecked {
            return a - b;
        }
    }
}
// 自由函数
function sum(uint[] memory arr) pure returns (uint sum) {
    for (uint i = 0; i < arr.length; i++) {
        sum += arr[i];
    }
}

contract Sharer {
    function sendHalf(address payable addr) public payable returns (uint) {
        uint balanace = address(this).balance;
        addr.transfer(msg.value / 2);
        assert(address(this).balance == balanace - msg.value / 2);
        return address(this).balance;
    }
    bool found;
    function f(uint[] memory arr) public {
        uint s = sum(arr);
        require(s > 5);
        found = true;
    }

    function arithmetic(uint a, uint b) public pure returns (uint, uint) {
        return (a + b, a * b);
    }
}
