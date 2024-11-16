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

### Please don't steal my api key just because I'm being lazy rn

```shell
vlayer serve \
  --rpc-url '31337:http://localhost:8545' \
  --rpc-url '11155111:https://sepolia.infura.io/v3/16d5e43545934be1a450a1538afbd007' \
  --rpc-url '1:https://mainnet.infura.io/v3/16d5e43545934be1a450a1538afbd007' \
  --rpc-url '8453:https://base-mainnet.infura.io/v3/16d5e43545934be1a450a1538afbd007' \
  --rpc-url '10:https://optimism-mainnet.infura.io/v3/16d5e43545934be1a450a1538afbd007'
```
