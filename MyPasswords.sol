// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract MyPasswords {
    struct MyAccount {
        string name;
        string secret;
    }

    address private owner;
    MyAccount[] private accounts;

    constructor() {
        owner = msg.sender;
    }

    function addAccount(string memory name, string memory secret) external {
        require(owner == msg.sender, "Only the owner can add accounts");
        MyAccount memory newAccount = MyAccount(name, secret);
        accounts.push(newAccount);
    }

    function listAccounts() external view returns (MyAccount[] memory) {
        require(owner == msg.sender, "Only the owner can list accounts");
        return accounts;
    }
}
