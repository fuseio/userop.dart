## [0.0.8]

### Changed
- Skip `getGasPrice` middleware if `maxFeePerGas` & `maxPriorityFeePerGas` are set.

## [0.0.7]

### Added
- A new preset `EtherspotWallet`. It's based on [EtherspotWallet.sol](https://github.com/etherspot/etherspot-prime-contracts/blob/master/src/wallet/EtherspotWallet.sol).

## [0.0.6]

### Added
- A new preset `Kernel`. It's based on [ZeroDev](https://docs.zerodev.app/).

### Changed
- **Breaking:** `execute` & `executeBatch` is now getting `Call` instead of to, value and data.

## [0.0.5]

### Changed
- **Breaking:** `verifyingPaymaster` is now getting just the address of the paymaster rpc service instead of the JsonRPC provider instance.

## [0.0.4]

### Added
- Documentation

## [0.0.3]

### Added
- A default example for pub.dev

## [0.0.2]

### Fixed
- Parse `BigInt` to hex string

## [0.0.1]

- Initial version.
