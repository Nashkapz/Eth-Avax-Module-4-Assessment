// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "hardhat/console.sol";

// A smart contract named DegenToken is created. It inherits features from ERC20, Ownable, and ERC20Burnable.
contract DegenToken is ERC20, Ownable, ERC20Burnable {

    constructor() ERC20("Degen", "DGN") {}

    // Mint new tokens and allocate them to an address. Only the owner can call this function.
    function MintingToken(address to, uint128 value) external onlyOwner {
        _mint(to, value);
    }

    // Transfer tokens from the caller's address to another address after approval.
    function TransferingTokens(address to, uint128 value) external {
        require(balanceOf(msg.sender) >= value, "Not enough tokens to transfer.");
        approve(msg.sender, value);
        transferFrom(msg.sender, to, value);
    }

    // Check the token balance of the caller's address.
    function CheckingBalance() external view returns (uint128) {
        return balanceOf(msg.sender);
    }

    // Burn a specific amount of tokens from the caller's address.
    function BurningTokens(uint128 value) external {
        require(balanceOf(msg.sender) >= value, "Not enough tokens to burn.");
        _burn(msg.sender, value);
    }

    // Return a description of items available in the game store.
    function GameStore() external pure returns (string memory) {
        return "1. UltraDegeniteSword value = 500\n2. HydroDegeniteSword value = 250\n3. DegeniteSword value = 100";
    }

    // Redeem items from the game store using tokens. Choice should be 1, 2, or 3.
    function ReedemingTokens(uint128 choice) external payable {
        require(choice >= 1 && choice <= 3, "Choose a valid item.");
        uint128 requiredTokens = (choice == 1) ? 500 : (choice == 2) ? 250 : 100;
        require(balanceOf(msg.sender) >= requiredTokens, "Not enough tokens to redeem.");
        approve(msg.sender, requiredTokens);
        transferFrom(msg.sender, owner(), requiredTokens);
    }
}
