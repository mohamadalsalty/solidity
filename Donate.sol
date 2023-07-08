// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Donate {
    address payable private owner;
    event DonationReceived(address indexed donor, uint256 amount);

    constructor() {
        owner = payable(msg.sender);
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function donate() public payable {
        require(msg.value > 0, "Donation amount must be greater than 0");
        emit DonationReceived(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) public {
        require(
            msg.sender == owner,
            "Only the contract owner can withdraw funds"
        );
        require(
            address(this).balance >= amount,
            "Insufficient contract balance"
        );

        owner.transfer(amount);
    }

    receive() external payable {
        donate();
    }
}
