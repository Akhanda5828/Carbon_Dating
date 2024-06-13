// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC20/ERC20.sol)
pragma solidity ^0.8.20;

import ".deps/npm/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import ".deps/npm/@openzeppelin/contracts/access/Ownable.sol";

contract CarbonCreditToken is ERC20, Ownable {
    // Mapping to store authorized minters
    mapping(address => bool) public authorizedMinters;

    constructor(string memory name, string memory symbol, address initialOwner) ERC20(name, symbol) Ownable(initialOwner) {}

    // Modifier to restrict function access to authorized minters only
    modifier onlyAuthorizedMinter() {
        require(authorizedMinters[msg.sender], "Not an authorized minter");
        _;
    }

    // Function to authorize a new minter
    function authorizeMinter(address minter) public onlyOwner {
        authorizedMinters[minter] = true;
    }

    // Function to revoke a minter's authorization
    function revokeMinter(address minter) public onlyOwner {
        authorizedMinters[minter] = false;
    }

    // Mint function restricted to authorized minters
    function mint(address to, uint256 amount) public onlyAuthorizedMinter {
        _mint(to, amount);
    }

    // Burn function to allow any user to destroy their tokens
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    // Override _update to add audit trail
    function _update(address from, address to, uint256 amount) internal virtual override {
        super._update(from, to, amount);
        // Emit a detailed transfer event for audit purposes
        emit TransferDetails(from, to, amount, block.timestamp);
    }

    // Event to log transfer details
    event TransferDetails(address indexed from, address indexed to, uint256 value, uint256 timestamp);
}
