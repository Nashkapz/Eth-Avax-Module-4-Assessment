// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "hardhat/console.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {

    constructor() ERC20("Degen", "DGN") {}

        function MintingToken(address to, uint128 value) public onlyOwner{
            _mint(to, value);
        }
        function TransferingTokens(address _address, uint128 value) external{
            require(balanceOf(msg.sender) >= value, "You don't have enough tokens to transfer.");
            approve(msg.sender, value);
            transferFrom(msg.sender, _address, value);
        }
        function CheckingBalance() external view returns(uint128){
           return balanceOf(msg.sender);
        }
        function BurningTokens(uint128 value) external{
            require(balanceOf(msg.sender)>= value, "You do not have enough tokens to burn.");
            _burn(msg.sender, value);
        }
        function GameStore() public pure returns(string memory) {
            return "1. UltraDegeniteSword value = 500 \n 2. HydroDegeniteSword value = 250 \n 3. DegeniteSword value = 100";
        }
        function ReedemingTokens(uint128 choice) external payable{
            require(choice >= 1 && choice <= 3,"Choose valid Item.");
            if(choice == 1){
                require(balanceOf(msg.sender) >= 500, "You don't have required number of tokens in wallet.");
                approve(msg.sender, 500);
                transferFrom(msg.sender, owner(), 500);
            }
            else if(choice == 2){
                require(balanceOf(msg.sender) >= 250, "You don't have required number of tokens in wallet.");
                approve(msg.sender, 250);
                transferFrom(msg.sender, owner(), 250);
            }
            else{
                require(balanceOf(msg.sender) >= 100, "You don't have required number of tokens in wallet.");
                approve(msg.sender, 100);
                transferFrom(msg.sender, owner(), 100);
            }


        }

}
