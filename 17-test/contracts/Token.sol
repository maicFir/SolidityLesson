pragma solidity ^0.8.28;

contract Token {
    string public name = "My Token";
    string public symbol = "MTK";
    uint256 public totalSupply = 1000000;
    address public owner;
    mapping(address => uint256) public balanceOf;
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Balance(
        address indexed account,
        uint256 balance,
        uint256 senderBalance
    );
    constructor() {
        balanceOf[msg.sender] = totalSupply;
        owner = msg.sender;
    }
    function transfer(address to, uint256 amount) external {
        // Check if the transaction sender has enough tokens.
        // Check if the transaction sender has enough tokens.
        require(balanceOf[msg.sender] >= amount, "Not enough tokens");

        require(amount > 10, "Amount must be greater than 10");

        // Subtract the amount from the sender's balance.
        balanceOf[msg.sender] -= amount;
        // Add the amount to the recipient's balance.
        balanceOf[to] += amount;

        // Notify off-chain applications of the transfer.
        emit Transfer(msg.sender, to, amount);
        emit Balance(to, balanceOf[to], balanceOf[msg.sender]);
    }
    function getBalance(address account) external view returns (uint256) {
        return balanceOf[account];
    }
}
