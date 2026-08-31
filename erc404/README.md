# ERC-404 on Monad

ERC-404 is an experimental token implementation by Pandora Labs. A single
contract exposes both ERC-20 and ERC-721 interfaces. ERC-404 is not an official
Ethereum standard and has not been standardized. Review the code before using it
in production.

This project deploys `ERC404Example`. The deployer is set as ERC-721
transfer-exempt and receives the full ERC-20 supply.

This project contains the upstream core (`ERC404.sol`, `ERC404U16.sol`, and their
`interfaces/` and `lib/` files) and the `ERC404Example` contract. The
Uniswap-specific examples and extensions from the upstream repository are not
included, which keeps the dependency set to OpenZeppelin only.

The contract source in `src/` is copied without modification from
[Pandora-Labs-Org/erc404](https://github.com/Pandora-Labs-Org/erc404) at commit
`ba960f6`.

## Before you begin

- Install Foundry v1.8.0 or later (required for `network = "monad"`).
- Have an account funded with MON. For testnet, use https://faucet.monad.xyz.

## Install dependencies

This project depends on OpenZeppelin Contracts v5 and forge-std. Install the
pinned versions into the `lib` directory:

```
cd erc404
forge install OpenZeppelin/openzeppelin-contracts@v5.4.0 foundry-rs/forge-std@v1.16.2
```

These are the versions this example is tested against. Pinning avoids a future
release breaking the build. Import mappings are defined in `remappings.txt`.
OpenZeppelin v5 requires solc 0.8.20 or later; this project uses 0.8.26.

## Build

```
forge build
```

`forge lint` (which runs during the build on Foundry v1.8+) reports findings in
the vendored upstream source. The source is upstream code, unmodified; the
findings do not block the build.

## Configure the token

The deployment script reads the following environment variables. If a variable is
not set, the script uses the default value. The `decimals` value is fixed at 18.

| Variable | Description | Default |
| --- | --- | --- |
| `TOKEN_NAME` | Token name. | `Monad ERC404` |
| `TOKEN_SYMBOL` | Token symbol. | `mE404` |
| `MAX_NFT_SUPPLY` | Maximum ERC-721 supply. The deployer receives `MAX_NFT_SUPPLY * 10**18` ERC-20 tokens. | `100` |

## Deploy

1. Import a deployer key into a Foundry keystore. Use a key that holds only
   testnet funds. The command prompts for the private key and a password.

   ```
   cast wallet import monad-deployer --interactive
   ```

2. Run the deployment script against Monad testnet. To override the defaults, set
   the environment variables on the same line.

   ```
   TOKEN_NAME="Monad ERC404" TOKEN_SYMBOL="mE404" MAX_NFT_SUPPLY=100 \
   forge script script/DeployERC404Example.s.sol:DeployERC404Example \
     --rpc-url monad_testnet \
     --account monad-deployer \
     --broadcast
   ```

The script prints the deployed contract address.

To deploy to mainnet, change `--rpc-url monad_testnet` to `--rpc-url monad`.

To sign with a raw private key instead of a keystore, replace
`--account monad-deployer` with `--private-key <key>`.

## Verify

Verify the contract on the block explorer with Sourcify:

```
forge verify-contract <address> src/examples/ERC404Example.sol:ERC404Example \
  --chain 10143 \
  --verifier sourcify \
  --verifier-url https://sourcify-api-monad.blockvision.org
```

To verify on MonadScan instead, use `--verifier etherscan` with a MonadScan API
key and drop the `--verifier-url` flag. For mainnet, use `--chain 143`.

## License

ERC-404 is MIT-licensed, declared through the SPDX identifiers in its source
files. The upstream repository does not include a standalone LICENSE file; the
`LICENSE` file in this directory was added here to state the MIT terms
explicitly.

## Build settings

solc 0.8.26, optimizer enabled with 200 runs. `network = "monad"` (Foundry
v1.8.0+) selects Monad execution rules for local runs; the hardfork defaults to
MonadTen. `use_literal_content = true` embeds the full source in contract
metadata for Sourcify verification.
