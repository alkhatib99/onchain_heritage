
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract OnchainHeritage {
    mapping(address => bool) public hasParticipated;
    uint256 public totalInteractions;

    event Participated(address indexed user, uint256 totalInteractions);

    function participate() external {
        require(!hasParticipated[msg.sender], "Already participated");
        hasParticipated[msg.sender] = true;
        totalInteractions += 1;
        emit Participated(msg.sender, totalInteractions);
    }
}
