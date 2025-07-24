pragma solidity ^0.8.20;

// 定义错误
error NotEnough(uint requested, uint available);

contract Token {
    mapping(address => uint256) public balances; // 定义映射
    // 定义结构体
    struct Voter {
        uint wight;
        bool isVoted;
        address delegate;
        uint vote;
    }
    mapping(uint => Voter) campaigns;
    enum State {
        Register,
        Vote,
        Done
    }
    State public state; // 定义状态

    constructor(uint256 initialSupply) {
        balances[msg.sender] = initialSupply; // 初始化余额
    }
    // 转账函数
    function transfer(address to, uint256 amount) public {
        // 检查余额是否足够
        if (amount > balances[msg.sender]) {
            revert NotEnough(amount, balances[msg.sender]);
        }
        balances[msg.sender] -= amount; // 从发送者账户中扣除金额
        balances[to] += amount; // 将金额添加到接收者账户中
    }

    function setRegister() public {
        state = State.Register;
    }

    function getState() public view returns (State) {
        return state;
    }
}
