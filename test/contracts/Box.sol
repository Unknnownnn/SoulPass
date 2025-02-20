// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./access-control/Auth.sol";

contract Box {
    uint256 private _tokenIdCounter;
    mapping(address => uint256) private _balances;
    mapping(address => uint256) private _reputationScores;
    mapping(address => bool) private _soulboundTokensMinted;

    event LoanRepaid(address indexed user, uint256 amount);
    event ReputationUpdated(address indexed user, uint256 newScore);
    event SoulboundTokenMinted(address indexed user);

    function repayLoan(uint256 amount) public {
        require(amount > 0, "Repayment amount must be greater than 0");

        // Business logic for loan repayment
        _balances[msg.sender] += amount; // Simulated repayment tracking

        emit LoanRepaid(msg.sender, amount);

        // Update reputation score
        _reputationScores[msg.sender] += 10; // Increment score by a fixed amount
        emit ReputationUpdated(msg.sender, _reputationScores[msg.sender]);

        // Mint soulbound token if not already minted
        if (!_soulboundTokensMinted[msg.sender]) {
            _soulboundTokensMinted[msg.sender] = true;
            emit SoulboundTokenMinted(msg.sender);
        }
    }

    function getReputation(address user) public view returns (uint256) {
        return _reputationScores[user];
    }

    function hasSoulboundToken(address user) public view returns (bool) {
        return _soulboundTokensMinted[user];
    }
}
