// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "./IStrategy.sol";

/**
 * @title YieldVault
 * @dev Professional vault contract that manages user funds and directs them to a strategy.
 */
contract YieldVault is ERC20, Ownable {
    using SafeERC20 for IERC20;

    IERC20 public token;
    IStrategy public strategy;

    constructor(address _token) ERC20("Yield Vault Token", "yTKN") Ownable(msg.sender) {
        token = IERC20(_token);
    }

    function setStrategy(address _strategy) external onlyOwner {
        strategy = IStrategy(_strategy);
    }

    function deposit(uint256 _amount) external {
        uint256 _pool = balance();
        uint256 _before = token.balanceOf(address(this));
        token.safeTransferFrom(msg.sender, address(this), _amount);
        uint256 _after = token.balanceOf(address(this));
        _amount = _after - _before; // Handle fee-on-transfer tokens

        uint256 shares = 0;
        if (totalSupply() == 0) {
            shares = _amount;
        } else {
            shares = (_amount * totalSupply()) / _pool;
        }
        _mint(msg.sender, shares);
        
        // Push funds to strategy
        token.safeTransfer(address(strategy), token.balanceOf(address(this)));
        strategy.deposit();
    }

    function balance() public view returns (uint256) {
        return token.balanceOf(address(this)) + strategy.balanceOf();
    }

    function withdraw(uint256 _shares) external {
        uint256 r = (balance() * _shares) / totalSupply();
        _burn(msg.sender, _shares);

        uint256 b = token.balanceOf(address(this));
        if (b < r) {
            uint256 _withdraw = r - b;
            strategy.withdraw(_withdraw);
        }

        token.safeTransfer(msg.sender, r);
    }
}
