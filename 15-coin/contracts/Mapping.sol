pragma solidity ^0.8.20;

struct IndexValue {
    uint keyIndex;
    uint value;
}
struct KeyFlag {
    uint key;
    bool deleted;
}

struct itmap {
    mapping(uint => IndexValue) data;
    KeyFlag[] keys;
    uint size;
}
library IterableMapping {
    function insert(
        itmap storage self,
        uint key,
        uint value
    ) internal returns (bool replaced) {
        uint keyIndex = self.data[key].keyIndex;
        self.data[key].value = value;
        if (keyIndex > 0) return true;
        else {
            keyIndex = self.keys.length;
            self.keys.push();
            self.data[key].keyIndex = keyIndex + 1;
            self.keys[keyIndex].key = key;
            self.size++;
            return false;
        }
    }
    function contains(
        itmap storage self,
        uint key
    ) internal view returns (bool) {
        return self.data[key].keyIndex > 0;
    }
}
contract MapingExample {
    mapping(address => uint) public balances;
    itmap data;
    using IterableMapping for itmap;

    function insert(uint k, uint v) public returns (uint) {
        data.insert(k, v);
        return data.size;
    }
    function update(uint newBalance) public {
        balances[msg.sender] = newBalance;
    }
}
contract MappingUser {
    function f() public returns (uint) {
        MapingExample example = new MapingExample();
        example.update(100);
        return example.balances(address(this));
    }
}
