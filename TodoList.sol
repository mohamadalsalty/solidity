// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract TodoList {
    struct TodoItem {
        string task;
        bool isCompleted;
    }
    address owner;
    mapping(uint256 => TodoItem) public list;
    uint256 public count = 0;

    event TaskCompleted(uint256 indexed id);

    constructor() {
        owner = msg.sender;
    }

    function addTask(string calldata task) public onlyOwner {
        TodoItem memory item = TodoItem({task: task, isCompleted: false});
        list[count] = item;
        count++;
    }

    function setCompleted(uint256 id) public onlyOwner {
        if (!list[id].isCompleted) {
            list[id].isCompleted = true;
            emit TaskCompleted(id);
        }
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }
}
