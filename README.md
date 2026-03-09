# Yield Aggregator Strategy Optimizer

This repository provides a professional framework for building yield-optimizing vaults. It separates the "Vault" (where users deposit) from the "Strategy" (where the yield is generated), allowing for seamless upgrades and risk management.

## Architecture
- **Vault**: Manages user deposits, withdrawals, and share accounting (ERC-20).
- **Strategy**: The engine that interacts with external DeFi protocols (e.g., Aave, Compound, Curve).
- **Controller**: Manages the connection between the Vault and the Strategy.

## Key Features
- **Auto-Harvesting**: Automated compounding of rewards back into the principal.
- **Dynamic Rebalancing**: Logic to shift funds to the highest-yielding protocol.
- **Slippage Protection**: Safety checks for swaps during reward conversion.

## License
MIT
