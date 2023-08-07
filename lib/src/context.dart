import 'dart:typed_data';

import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

import 'types.dart';
import 'utils/utils.dart';

class UserOperationMiddlewareCtx implements IUserOperationMiddlewareCtx {
  UserOperationMiddlewareCtx(this.op, this.entryPoint, this.chainId);

  @override
  BigInt chainId;

  @override
  EthereumAddress entryPoint;

  @override
  IUserOperation op;

  @override
  Uint8List getUserOpHash() {
    final packed = encodeAbi(
      [
        'address',
        'uint256',
        'bytes32',
        'bytes32',
        'uint256',
        'uint256',
        'uint256',
        'uint256',
        'uint256',
        'bytes32',
      ],
      [
        EthereumAddress.fromHex(op.sender),
        op.nonce,
        keccak256(hexToBytes(op.initCode)),
        keccak256(hexToBytes(op.callData)),
        op.callGasLimit,
        op.verificationGasLimit,
        op.preVerificationGas,
        op.maxFeePerGas,
        op.maxPriorityFeePerGas,
        keccak256(hexToBytes(op.paymasterAndData)),
      ],
    );

    final enc = encodeAbi(
      ['bytes32', 'address', 'uint256'],
      [keccak256(packed), entryPoint, chainId],
    );

    return keccak256(enc);
  }
}
