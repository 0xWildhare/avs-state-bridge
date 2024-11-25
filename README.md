## Some of the required workarounds and/or packages added :

bc one dev was running Ubuntu 22.04 instead of 24.04:

```shell
mkdir vlayer && curl https://vlayer-releases.s3.eu-north-1.amazonaws.com/latest/nightly-linux-amd64-musl.tar.gz -L | tar -xzC vlayer/
```

to correctly add the vlayer sdk:

```shell
forge soldeer install vlayer~0.1.0-nightly-20241115-70dfc11
```

vlayer/package.json line 7:

```shell
"@vlayer/sdk": "0.1.0-nightly-20241115-70dfc11",
```

for eigenlayer middleware contracts:

```shell
forge soldeer install eigenlayer-middleware~1.0.0 git@github.com:Layr-Labs/eigenlayer-middleware.git
```

for EAS contracts:

```shell
forge soldeer install eas~1.0.0 git@github.com:ethereum-attestation-service/eas-contracts.git
```

## Links (from contracts shown in demo video)

Schema:
https://sepolia.easscan.org/schema/view/0xa32d6035177ed38ff04a668dd7cd0fd06acc7016648c4f18bdf2df2880e4d0bd

Attestation:
https://sepolia.easscan.org/attestation/view/0xc20fd4b006f8a39ac8fd76b23730e0ffa48822baee6d9ee606c679e04d845536

Attestation txn:
https://sepolia.etherscan.io/tx/0xdee570405f08a1e79236928318bd66e08f8f953788a3209e32a6c2df2cc4aabd

prover (unverified):
https://sepolia.etherscan.io/address/0xca4b7f9b702a86c64eb15b685e9860f80edde957

verifier (unverified):
https://sepolia.etherscan.io/address/0x57d0a735310d9e575cfe17ee5061e6616026f482

resolver (unverified):
https://sepolia.etherscan.io/address/0xc74e2c521107905ec893d0ec1f8ac3f4aea65ea0

EAS registration txn:
https://sepolia.etherscan.io/tx/0x17f61acfdddac7bf9802d1b233eae1bb43cdbe775e6c783287347ea83aa2f31b

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
