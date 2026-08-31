// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {SimpleDN404} from "../src/example/SimpleDN404.sol";
import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

/// @notice Deploys SimpleDN404 (a Vectorized DN-404 example) to Monad.
///
/// Usage:
///   forge script script/DeploySimpleDN404.s.sol:DeploySimpleDN404 \
///     --rpc-url monad_testnet --private-key $PRIVATE_KEY --broadcast
contract DeploySimpleDN404 is Script {
    function run() external {
        // Whole-token supply. Each 1e18 base unit auto-mints one NFT to a
        // non-exempt holder, so this doubles as the maximum NFT count.
        uint256 supplyTokens = vm.envOr("TOKEN_SUPPLY", uint256(1000));
        string memory name = vm.envOr("TOKEN_NAME", string("Monad DN404"));
        string memory symbol = vm.envOr("TOKEN_SYMBOL", string("mDN"));

        vm.startBroadcast();
        // Deployer receives the full supply and contract ownership.
        SimpleDN404 token =
            new SimpleDN404(name, symbol, uint96(supplyTokens * 1e18), msg.sender);
        vm.stopBroadcast();

        console.log("SimpleDN404 (ERC-20 side):", address(token));
        console.log("DN404Mirror (ERC-721 side) is created in the same tx --");
        console.log("find it in broadcast/.../run-latest.json or the explorer trace.");
    }
}
