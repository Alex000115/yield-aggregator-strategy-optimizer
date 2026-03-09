// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 * @title IStrategy
 * @dev Interface for all yield-generating strategies.
 */
interface IStrategy {
    function want() external view returns (IERC20);
    function deposit() external;
    function withdraw(uint256 amount) external;
    function withdrawAll() external returns (uint256);
    function balanceOf() external view returns (uint256);
    function harvest() external;
}
