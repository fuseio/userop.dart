## [0.1.9]

### Changed
- Downgrade `http` package to `1.2.0`.

## [0.1.8]

### Fixed
- Retrieving the gas price for chains compatible with EIP-1559.

## [0.1.7]

### Fixed
- Retrieving the gas price for chains compatible with EIP-1559.

### Changed
- The condition to skip the `getGasPrice` middleware when both `maxFeePerGas` and `maxPriorityFeePerGas` are specified has been removed.

## [0.1.6]

### Fixed
- Prevent AA20 when deploying new Account with nonceKey > 0 by

## [0.1.5]

### Fixed
- Init code is required for the contract creation.

## [0.1.4]

### Fixed
- Filter user operation using the `userOpHash`

## [0.1.3]

### Changed
- Retrieve the Smart Contract Account (SCA) from the wallet factory, rather than from the EntryPoint.

## [0.1.2]

### Added
- Allow to specify nonce key in `getNonce` method.

## [0.1.0]

### Changed
- Deprecated `EOASignature` middleware, replaced with `signUserOpHash`.
- Removed `estimateCreationGas` from gasLimit middleware for redundancy reduction.

## [0.0.12]

### Reverted
- The change that removed the defaults for `callGasLimit`, `verificationGasLimit`,
`preVerificationGas` fields in the `defaultUserOp` constructor of `IUserOperation` class

## [0.0.11]

### Fixed
- The issue with trying to set default values for gas limits
when the values were not provided.

## [0.0.10]

### Changed
- `callGasLimit`, `verificationGasLimit`, `preVerificationGas` fields are now nullable
and there aren't any defaults provided for them in the `defaultUserOp` constructor of
`IUserOperation` class.
- You can specify default values for `callGasLimit`, `verificationGasLimit`,
`preVerificationGas` while initializing the `EtherspotWallet`.

## [0.0.9]

### Changed
- Use the latest EtherspotWalletFactory contract deployed on Fuse.

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
