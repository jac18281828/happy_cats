### Deployment Adressess

| Network | Address                                    | Contract                    | Notes                      | Verified                                                                         |
| ------- | ------------------------------------------ | --------------------------- | -------------------------- | -------------------------------------------------------------------------------- |
| Sepolia | 0x66142F5058122d03967D9029756caCcf29450c7B | ProxyAdmin                  | Transparent Proxy Delegate | https://sepolia.etherscan.io/address/0x66142F5058122d03967D9029756caCcf29450c7B. |
| Sepolia | 0x161A73333250907C5Ce79c6D785C898Ffb2d6a85 | TransparentUpgradeableProxy | Chicken Pool Proxy         | https://sepolia.etherscan.io/address/0x161A73333250907C5Ce79c6D785C898Ffb2d6a85  |
| Sepolia | 0x2e3575c1C389a67Ac5DC418b0637389fC0F23658 | HappyCats                   | Happy Cats Implementation  | https://sepolia.etherscan.io/address/0x2e3575c1C389a67Ac5DC418b0637389fC0F23658  |


## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

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
# happy_cats
