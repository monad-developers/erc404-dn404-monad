// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC404Example} from "../src/examples/ERC404Example.sol";
import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

/// @notice Deploys ERC404Example (a Pandora Labs ERC-404 example) to Monad.
///
/// Usage:
///   forge script script/DeployERC404Example.s.sol:DeployERC404Example \
///     --rpc-url monad_testnet --private-key $PRIVATE_KEY --broadcast
contract DeployERC404Example is Script {
    function run() external {
        uint8 decimals = 18;
        // Max ERC-721 supply; the deployer is set transfer-exempt and receives
        // the full ERC-20 supply (maxTotalSupplyERC721 * 10**decimals).
        uint256 maxNftSupply = vm.envOr("MAX_NFT_SUPPLY", uint256(100));
        string memory name = vm.envOr("TOKEN_NAME", string("Monad ERC404"));
        string memory symbol = vm.envOr("TOKEN_SYMBOL", string("mE404"));

        vm.startBroadcast();
        address owner = msg.sender; // initial owner + mint recipient
        ERC404Example token =
            new ERC404Example(name, symbol, decimals, maxNftSupply, owner, owner);
        vm.stopBroadcast();

        console.log("ERC404Example deployed at:", address(token));
    }
}
