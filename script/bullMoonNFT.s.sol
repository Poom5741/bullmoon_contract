// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {BullMoonNFT} from "../src/BullMoonNFT.sol";
import {console} from "forge-std/console.sol";

contract DeployBullMoonNFT is Script {
    function run() external {
        // Private key from environment variable
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        // Base URI for Pinata-hosted metadata
        string memory baseURI = "ipfs://Qmb8PuWfKrqn1d7yuXRP8FV5G2BzaYnFCxihHFb7AkWYVZ/";

        // Start broadcasting transactions
        vm.startBroadcast(deployerPrivateKey);

        // Deploy the BullMoonNFT contract
        BullMoonNFT nft = new BullMoonNFT(baseURI);
        
        // Enable minting
        nft.toggleMinting(true);

        // Stop broadcasting
        vm.stopBroadcast();

        // Log the contract address
        console.log("BullMoonNFT deployed to:", address(nft));
    }
}