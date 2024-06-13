# ETH_Intermmediate

This contract is written on Solidity and has very basic functionalities related to the creation of decentralised Voting System.

## Description

This Smart Contract consists of simple functions and variables which helps in mapping of the data along with its minting and also helps us to burn the resources whenever needed.
## Getting Started

### Executing program

Before executing the program you have to download and keep both the ERC20 and Ownable files in the same directory as the CarbonDating solidity file.

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., SafeVoting.sol). Copy and paste the following code into the file:

```javascript
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

```

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.20" (or another compatible version), and then click on the "Compile CarbonDating.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "CarbonDating" contract from the dropdown menu, and then click on the "Deploy" button.

Now inorder for the Deployment to work we have to enter a valid name, symbol and the amount of tokens to be approved. After that we have several functions like authorize, where we have to enter the address of the person to be approved and then we can use the mint function to mint certain number of tokens only for the authorised minters. The Burn function helps us to burn the resources and the we can use revoke authorisation by entering the address and also transfer resources from a particular address to another address.
## Authors

Akhanda Pal Biswas
[@Chandigarh University](https://www.linkedin.com/in/akhanda-pal-biswas-445a88230/)


## License

This project is licensed under the MIT License - see the LICENSE.md file for details
