// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract QueueSystem {
    struct User {
        address userAddress;
        uint256 position;
        uint256 timestamp;
        bool done;
        uint256 doneAt;
    }

    uint256 latestPosition = 0;
    address owner;

    mapping(uint256 => User) private queue;

    constructor() {
        owner = msg.sender;
    }

    function joinQueue() public {
        latestPosition++;
        User memory newUser = User({
            userAddress: msg.sender,
            position: latestPosition,
            timestamp: block.timestamp,
            done: false,
            doneAt: 0
        });
        queue[latestPosition] = newUser;
    }

    function getQueue() public view returns (User[] memory) {
        User[] memory userQueue = new User[](latestPosition);
        for (uint256 i = 1; i <= latestPosition; i++) {
            userQueue[i - 1] = queue[i];
        }
        return userQueue;
    }

    function markAsDone(uint256 position) public {
        require(position > 0 && position <= latestPosition, "Invalid position");

        User storage user = queue[position];
        require(
            msg.sender == user.userAddress,
            "Only the user can mark as done"
        );
        require(!user.done, "User is already marked as done");

        user.done = true;
        user.doneAt = block.timestamp;
    }
}
