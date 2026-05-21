# Real-World Asset (RWA) Lending Engine

This repository provides an expert-level implementation of a credit market where physical assets (tokenized as NFTs or ERC-20s) serve as collateral. It bridges the gap between traditional asset value and decentralized liquidity.

### Core Mechanics
* **Collateralization:** Users lock RWA tokens into the `LendingPool`.
* **Dynamic LTV:** The Loan-to-Value ratio is adjusted in real-time based on the asset's risk profile and current appraisal.
* **Interest Rate Model:** Implements a utilization-based interest curve to balance supply and demand.
* **Automated Liquidations:** If the appraised value of the RWA drops below the liquidation threshold, the asset is flagged for auction to protect lender principal.

### Technical Components
* **LendingPool.sol:** Handles the primary logic for borrowing and repayment.
* **AppraisalOracle.sol:** Integrates with off-chain legal and valuation data to update collateral value.
* **RiskEngine.sol:** Calculates health factors and maximum borrowing capacity.
