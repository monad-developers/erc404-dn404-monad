# DN-404 on Monad

DN-404 is a token implementation by Vectorized. It links two contracts: an
ERC-20 contract and an ERC-721 mirror contract. When an account's balance crosses
a whole-token threshold, the mirror mints or burns a corresponding NFT. Both
contracts follow their respective standards.

This project deploys `SimpleDN404`. In this example the deployer receives the
entire token supply, and holders receive NFTs as they accumulate whole tokens.
The source also includes `NFTMintDN404`, a variant that supports public minting.

The contract source in `src/` is copied without modification from
[Vectorized/dn404](https://github.com/Vectorized/dn404) at commit `3397cb1`
(release v0.0.25).

## Before you begin

- Install Foundry v1.8.0 or later (required for `network = "monad"`).
- Have an account funded with MON. For testnet, use https://faucet.monad.xyz.

## Install dependencies

This project depends on Solady and forge-std. Install the pinned versions into
the `lib` directory:

```
cd dn404
forge install Vectorized/solady@v0.1.26 foundry-rs/forge-std@v1.16.2
```

These are the versions this example is tested against. Pinning avoids a future
Solady or forge-std release breaking the build. Import mappings are defined in
`remappings.txt`.

## Build

```
forge build
```

`forge lint` (which runs during the build on Foundry v1.8+) reports findings in
the vendored upstream source. The source is upstream code, unmodified; the
findings do not block the build.

## Configure the token

The deployment script reads the following environment variables. If a variable is
not set, the script uses the default value.

| Variable | Description | Default |
| --- | --- | --- |
| `TOKEN_NAME` | Token name. | `Monad DN404` |
| `TOKEN_SYMBOL` | Token symbol. | `mDN` |
| `TOKEN_SUPPLY` | Whole-token supply. Each whole token backs one NFT, so this is also the maximum NFT count. | `1000` |

## Deploy

1. Import a deployer key into a Foundry keystore. Use a key that holds only
   testnet funds. The command prompts for the private key and a password.

   ```
   cast wallet import monad-deployer --interactive
   ```

2. Run the deployment script against Monad testnet. To override the defaults, set
   the environment variables on the same line.

   ```
   TOKEN_NAME="Monad DN404" TOKEN_SYMBOL="mDN" TOKEN_SUPPLY=1000 \
   forge script script/DeploySimpleDN404.s.sol:DeploySimpleDN404 \
     --rpc-url monad_testnet \
     --account monad-deployer \
     --broadcast
   ```

The script prints the deployed ERC-20 address. The mirror ERC-721 contract is
created in the same transaction. Its address is recorded in
`broadcast/DeploySimpleDN404.s.sol/10143/run-latest.json` and shown in the block
explorer.

To deploy to mainnet, change `--rpc-url monad_testnet` to `--rpc-url monad`.

To sign with a raw private key instead of a keystore, replace
`--account monad-deployer` with `--private-key <key>`.

## Verify

Verify the ERC-20 contract on the block explorer with Sourcify:

```
forge verify-contract <address> src/example/SimpleDN404.sol:SimpleDN404 \
  --chain 10143 \
  --verifier sourcify \
  --verifier-url https://sourcify-api-monad.blockvision.org
```

Verify the mirror contract the same way, using
`src/DN404Mirror.sol:DN404Mirror`.

To verify on MonadScan instead, use `--verifier etherscan` with a MonadScan API
key and drop the `--verifier-url` flag. For mainnet, use `--chain 143`.

## Build settings

solc 0.8.26 and optimizer runs (1000) match the upstream DN-404 configuration.
`network = "monad"` (Foundry v1.8.0+) selects Monad execution rules for local
runs; the hardfork defaults to MonadTen. `use_literal_content = true` embeds the
full source in contract metadata for Sourcify verification.
