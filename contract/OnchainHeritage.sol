// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract OnchainHeritage {
    mapping(address => uint256) public interactions;
    uint256 public totalInteractions;

    event Participated(address indexed user, uint256 userTotal, uint256 total);

    function participate() public {
        interactions[msg.sender] += 1;
        totalInteractions += 1;

        emit Participated(msg.sender, interactions[msg.sender], totalInteractions);
    }
}