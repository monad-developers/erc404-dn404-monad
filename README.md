# ERC-404 and DN-404 examples for Monad

This repository contains deployable examples of two token implementations that
combine ERC-20 and ERC-721 behavior in a single asset. Both examples are
configured to build, deploy, and verify on Monad.

- **DN-404**, by Vectorized. A token that pairs an ERC-20 contract with a linked
  ERC-721 mirror contract. Both contracts are standard-compliant.
- **ERC-404**, by Pandora Labs. An experimental single-contract implementation
  that exposes both ERC-20 and ERC-721 interfaces. ERC-404 is not an official
  Ethereum standard.

Each example is a standalone [Foundry](https://book.getfoundry.sh) project. The
contract source is copied from the upstream projects without modification. This
repository adds a Monad build configuration, a deployment script, and
documentation.

## Contents

| Directory | Standard | Author | Deployable example |
| --- | --- | --- | --- |
| [`dn404/`](./dn404) | DN-404 | Vectorized | `SimpleDN404`, `NFTMintDN404` |
| [`erc404/`](./erc404) | ERC-404 | Pandora Labs | `ERC404Example` |

Each directory has its own README with step-by-step build, deploy, and verify
instructions.

## Before you begin

Install Foundry v1.8.0 or later. Foundry provides the `forge` and `cast`
command-line tools. Version 1.8.0 added native Monad support; both projects set
`network = "monad"` in `foundry.toml`, which earlier versions do not understand.

```
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

Check the installed version with `forge --version`.

You also need an account with a MON balance to pay for gas. For testnet, request
MON from the faucet at https://faucet.monad.xyz. Deploying either example costs
less than 1 MON at current testnet gas prices.

## Network parameters

The Foundry configuration in each project defines two named RPC endpoints:
`monad_testnet` and `monad`. Pass one to a command with `--rpc-url`, for example
`--rpc-url monad_testnet`.

| Parameter | Testnet | Mainnet |
| --- | --- | --- |
| Chain ID | 10143 | 143 |
| RPC URL | https://testnet-rpc.monad.xyz | https://rpc.monad.xyz |
| Currency | MON | MON |
| Block explorer | https://testnet.monadvision.com | https://monadvision.com |
| Faucet | https://faucet.monad.xyz | Not applicable |

## Deployed contracts

Reference deployments built from this repository, live on Monad testnet (chain
10143) and mainnet (chain 143). The deployer used a fresh account on both
networks, so each contract has the same address on both. All are verified with
Sourcify (exact match) on both networks:

| Contract | Address | Explorer |
| --- | --- | --- |
| `SimpleDN404` (ERC-20 side) | `0xA7575f7D294220e569BC20b9ee5bcA5dc71B647e` | [testnet](https://testnet.monadvision.com/address/0xA7575f7D294220e569BC20b9ee5bcA5dc71B647e) · [mainnet](https://monadvision.com/address/0xA7575f7D294220e569BC20b9ee5bcA5dc71B647e) |
| `DN404Mirror` (ERC-721 side) | `0x4AC38640823bd369Ae83758e99B604AF6754a38D` | [testnet](https://testnet.monadvision.com/address/0x4AC38640823bd369Ae83758e99B604AF6754a38D) · [mainnet](https://monadvision.com/address/0x4AC38640823bd369Ae83758e99B604AF6754a38D) |
| `ERC404Example` | `0x1B7A5e48c1Fe39ae38C642d7d9a0CD8FA85D253C` | [testnet](https://testnet.monadvision.com/address/0x1B7A5e48c1Fe39ae38C642d7d9a0CD8FA85D253C) · [mainnet](https://monadvision.com/address/0x1B7A5e48c1Fe39ae38C642d7d9a0CD8FA85D253C) |

Both projects use the default token parameters from the deploy scripts. The
deployments are examples; the standards remain experimental and unaudited (see
Status and audits).

## Deploy

Follow the README in the project you want to deploy:

- [dn404/README.md](./dn404/README.md)
- [erc404/README.md](./erc404/README.md)

The deploy scripts target testnet by default. To deploy to mainnet, change
`--rpc-url monad_testnet` to `--rpc-url monad` and fund the deployer account with
mainnet MON.

## Status and audits

ERC-404 is experimental and is not an official Ethereum standard. It has not been
standardized. DN-404 includes audit reports in its upstream repository. Review
and test the code before using it in production.

## Attribution

The contract source in this repository is copied without modification from these
projects:

- DN-404: [Vectorized/dn404](https://github.com/Vectorized/dn404) at commit
  `3397cb1` (release v0.0.25), MIT-licensed.
- ERC-404: [Pandora-Labs-Org/erc404](https://github.com/Pandora-Labs-Org/erc404)
  at commit `ba960f6`, MIT-licensed.

## License

The deployment scripts, build configuration, and documentation added by this
repository are released under the MIT License (see [LICENSE](./LICENSE)).

The upstream contract source is also MIT-licensed:

- DN-404 ships an upstream LICENSE file, copied verbatim to
  [dn404/LICENSE](./dn404/LICENSE) (© 2023 Pop Punk LLC).
- ERC-404 declares MIT through the SPDX identifiers in its source files and does
  not include a standalone LICENSE file. The [erc404/LICENSE](./erc404/LICENSE)
  file was added in this repository to state the MIT terms explicitly.
