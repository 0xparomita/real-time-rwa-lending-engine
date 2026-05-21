// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract LendingPool is ReentrancyGuard, Ownable {
    struct Loan {
        uint256 amount;
        uint256 collateralValue;
        uint256 startTime;
        bool active;
    }

    IERC20 public stablecoin;
    mapping(address => mapping(uint256 => Loan)) public loans; // user -> tokenId -> Loan
    uint256 public constant LTV_BPS = 7000; // 70% Loan-to-Value

    event LoanOpened(address indexed borrower, uint256 tokenId, uint256 amount);
    event LoanRepaid(address indexed borrower, uint256 tokenId);

    constructor(address _stablecoin) Ownable(msg.sender) {
        stablecoin = IERC20(_stablecoin);
    }

    function borrow(uint256 _tokenId, uint256 _collateralValue, uint256 _requestAmount) external nonReentrant {
        uint256 maxLoan = (_collateralValue * LTV_BPS) / 10000;
        require(_requestAmount <= maxLoan, "Exceeds max LTV");
        
        // Logic to lock the RWA NFT would go here
        
        loans[msg.sender][_tokenId] = Loan({
            amount: _requestAmount,
            collateralValue: _collateralValue,
            startTime: block.timestamp,
            active: true
        });

        stablecoin.transfer(msg.sender, _requestAmount);
        emit LoanOpened(msg.sender, _tokenId, _requestAmount);
    }

    function repay(uint256 _tokenId) external nonReentrant {
        Loan storage loan = loans[msg.sender][_tokenId];
        require(loan.active, "No active loan");

        uint256 totalRepayment = loan.amount; // In prod, add interest calculation
        stablecoin.transferFrom(msg.sender, address(this), totalRepayment);

        loan.active = false;
        // Logic to release RWA NFT
        emit LoanRepaid(msg.sender, _tokenId);
    }
}
