# userop.dart
## Table of Contents

- [userop.dart](#useropdart)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
      - [What is userop.dart?](#what-is-useropdart)
      - [Why userop.dart?](#why-useropdart)
  - [Installation](#installation)
    - [Examples](#examples)
      - [Create a simple account](#create-a-simple-account)
      - [Transfer funds](#transfer-funds)
      - [Transfer ERC20 token](#transfer-erc20-token)
      - [Batch transaction](#batch-transaction)
  - [Client](#client)
    - [Usage](#usage)
      - [sendUserOperation](#senduseroperation)
      - [buildUserOperation](#builduseroperation)
      - [constants](#constants)
  - [Provider](#provider)
    - [BundlerJsonRpcProvider](#bundlerjsonrpcprovider)
  - [Presets](#presets)
    - [Builder](#builder)
      - [Kernel](#kernel)
      - [Etherspot Wallet](#etherspot-wallet)
      - [SimpleAccount](#simpleaccount)
    - [Middleware](#middleware)
      - [estimateUserOperationGas](#estimateuseroperationgas)
      - [getGasPrice](#getgasprice)
      - [verifyingPaymaster](#verifyingpaymaster)
      - [eOASignature](#eoasignature)

## Introduction

#### What is userop.dart?

`userop.dart` is a comprehensive library tailored for crafting ERC-4337 User Operations. While `web3dart` equips developers to effortlessly generate standard EVM transactions, `userop.dart` streamlines the creation and dispatch of User Operations to ERC-4337 Bundlers.

#### Why userop.dart?

- 💪 Versatile Implementation: Suitable for generating User Operations for any ERC-4337 Smart Account, Bundler platform, or Paymaster.

- 🏗️ User-friendly architecture: Adopts the builder design pattern, reflecting the real-world construction of User Operations.

## Installation

 ```yaml               
dependencies:       
  userop: [latest-version]
```      

### Examples

#### [Create a simple account](./example/address.dart)

#### [Transfer funds](./example/transfer.dart)

#### [Transfer ERC20 token](./example/erc20_transfer.dart)

#### [Batch transaction](./example/batch_transfer.dart)

## Client

Connecting to an ERC-4337 bundler is easy using `userop.dart`

`userop.dart` allows you connect to a bundler RPC using the client interface.

An instance of a client is an abstraction for building and sending your User Operations to the `eth_sendUserOperation` RPC method on a bundler.

### Usage

```dart

import 'package:userop/userop.dart';

final String bundlerRPC = 'YOUR_BUNDLER_RPC_URL';
final iClientOpts = IClientOpts()
  ..overrideBundlerRpc = bundlerRPC
  ..entryPoint = EthereumAddress.fromHex('YOU_ENTRY_POINT' ?? ERC4337.ENTRY_POINT);

final client = await Client.init(
  bundlerRPC,
  opts: iClientOpts,
);

```

#### sendUserOperation

A method for directing a `builder` instance to create a User Operation and send it to a bundler via `eth_sendUserOperation`.

  ```dart

import 'package:userop/userop.dart';

final response = await client.sendUserOperation(
    await simpleAccount.execute(
      Call(
        to: targetAddress,
        value: amount,
        data: Uint8List(0),
      )
    ),
    opts: sendOpts,
);
final filterEvent = await response.wait();

  ```


#### buildUserOperation

This method can be used to direct a builder using the client's entryPoint and chainID. However it will only return the UserOperation and not initiate a send request.

  ```dart
final userOp = await client.buildUserOperation(builder);
  ```

#### constants

A instance of a client has several constants that can be set.

  ```dart
// The maximum amount of time to wait for the UserOperationEvent after calling response.wait()
client.waitTimeoutMs = 30000;

// The interval at which it will poll the node to look up UserOperationEvent.
client.waitIntervalMs = 5000;
  ```


## Provider

`userop.dart` provides a straightforward wrapper over `web3dart` JsonRPC, offering the flexibility to re-route bundler methods. By default, it assumes that both bundler and node methods share the same RPC url. However, in instances where this isn't the case, this module offers the added capability to override the bundler RPC, allowing all bundler RPC methods to be redirected to a different endpoint.

### BundlerJsonRpcProvider

  ```dart

import 'package:userop/userop.dart';
import 'package:http/http.dart' as http;

final String bundlerRPC = 'YOUR_BUNDLER_RPC_URL';
final provider = BundlerJsonRpcProvider(rpcUrl, http.Client());
  ```

## Presets

`userop.dart` comes bundled with common presets, facilitating a quicker setup for specific use cases.

### Builder

Builder presets offer pre-configured builders for known contract account implementations. These presets can be utilized directly or can be customized using get and set functions.

#### Kernel
The Kernel preset is an abstraction to build User Operations for an ERC-4337 account based on [ZeroDev Kernel V2](https://github.com/zerodevapp/kernel/blob/main/src/Kernel.sol) - a modular contract account framework. It deploys with the [ECDSA validator](https://github.com/zerodevapp/kernel/blob/main/src/validator/ECDSAValidator.sol) by default.

  ```dart
import 'package:userop/userop.dart';

final targetAddress = EthereumAddress.fromHex('YOUR_TARGET_ADDRESS');
final amount = BigInt.parse('AMOUNT_IN_WEI');
final signingKey = EthPrivateKey.fromHex('YOUR_PRIVATE_KEY');
final bundlerRPC = 'YOUR_BUNDLER_RPC_URL';
final opts = IPresetBuilderOpts()
  ..factoryAddress = EthereumAddress.fromHex(
    'YOUR_FACTORY_ADDRESS',
  );
final kernel = await Kernel.init(
    signingKey,
    bundlerRPC,
    opts: opts,
);

final client = await Client.init(bundlerRPC);

final res = await client.sendUserOperation(
    await kernel.execute(
      Call(
        to: targetAddress,
        value: amount,
        data: Uint8List(0),
      ),
    ),
);
print('UserOpHash: ${res.userOpHash}');

print('Waiting for transaction...');
final ev = await res.wait();
print('Transaction hash: ${ev?.transactionHash}');
  ```
  

#### Etherspot Wallet

The `EtherspotWallet` preset provides an abstraction to construct User Operations for an ERC-4337 account. It's based on [EtherspotWallet.sol](https://github.com/etherspot/etherspot-prime-contracts/blob/master/src/wallet/EtherspotWallet.sol).

  ```dart
import 'package:userop/userop.dart';

final targetAddress = EthereumAddress.fromHex('YOUR_TARGET_ADDRESS');
final amount = BigInt.parse('AMOUNT_IN_WEI');
final signingKey = EthPrivateKey.fromHex('YOUR_PRIVATE_KEY');
final bundlerRPC = 'YOUR_BUNDLER_RPC_URL';

final etherspotWallet = await EtherspotWallet.init(
    signingKey,
    bundlerRPC,
);

final client = await Client.init(bundlerRPC);

final res = await client.sendUserOperation(
    await etherspotWallet.execute(
      Call(
        to: targetAddress,
        value: amount,
        data: Uint8List(0),
      ),
    ),
);
print('UserOpHash: ${res.userOpHash}');

print('Waiting for transaction...');
final ev = await res.wait();
print('Transaction hash: ${ev?.transactionHash}');
  ```
  

#### SimpleAccount

The `SimpleAccount` preset provides an abstraction to construct User Operations for an ERC-4337 account. It's based on [SimpleAccount.sol](https://github.com/eth-infinitism/account-abstraction/blob/develop/contracts/samples/SimpleAccount.sol).

  ```dart
import 'package:userop/userop.dart';

final targetAddress = EthereumAddress.fromHex('YOUR_TARGET_ADDRESS');
final amount = BigInt.parse('AMOUNT_IN_WEI');
final signingKey = EthPrivateKey.fromHex('YOUR_PRIVATE_KEY');
final bundlerRPC = 'YOUR_BUNDLER_RPC_URL';

final simpleAccount = await SimpleAccount.init(
    signingKey,
    bundlerRPC,
);

final client = await Client.init(bundlerRPC);

final res = await client.sendUserOperation(
    await simpleAccount.execute(
      Call(
        to: targetAddress,
        value: amount,
        data: Uint8List(0),
      ),
    ),
);
print('UserOpHash: ${res.userOpHash}');

print('Waiting for transaction...');
final ev = await res.wait();
print('Transaction hash: ${ev?.transactionHash}');
  ```
  

### Middleware

Middleware presets are reusable implementations of middleware functions tailored for different builder instances.

#### estimateUserOperationGas

This middleware function is designed for sending UserOperations to the `eth_estimateUserOperationGas` endpoint, ensuring accurate gas limit estimations for `preVerificationGas`, `verificationGasLimit`, and `callGasLimit`.


  ```dart
import 'package:userop/userop.dart';

final builder = UserOperationBuilder();

builder = builder.useMiddleware(estimateUserOperationGas(
    Web3Client('RPC_URL', http.Client()),
    BundlerJsonRpcProvider('RPC_URL', http.Client()),
))
  ```

#### getGasPrice

This middleware function retrieves the latest values for `maxFeePerGas` and `maxPriorityFeePerGas`.

  ```dart
import 'package:userop/userop.dart';

final builder = UserOperationBuilder();

builder = builder.useMiddleware(getGasPrice(
    Web3Client('RPC_URL', http.Client()),
    BundlerJsonRpcProvider('RPC_URL', http.Client()),
))
  ```

#### verifyingPaymaster

This middleware function requests gas sponsorship from a Paymaster service. It assumes the service adheres to the proposed [JSON-RPC API for verifying paymasters](https://hackmd.io/@stackup/H1oIvV-qi).

 ```dart
final paymasterMiddleware = verifyingPaymaster(
  'YOUR_PAYMASTER_SERVICE_URL',
  {},
);

final IPresetBuilderOpts opts = IPresetBuilderOpts()
    ..paymasterMiddleware = paymasterMiddleware;

final simpleAccount = await SimpleAccount.init(
    signingKey,
    bundlerRPC,
    opts: opts,
);
 ```

#### eOASignature

A middleware function designed to sign the User Operation using an EOA private key.

  ```dart
import 'package:userop/userop.dart';

final builder = UserOperationBuilder();
builder = builder.useMiddleware(eOASignature(signer))
  ```
