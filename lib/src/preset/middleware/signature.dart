import 'package:userop/src/types.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/crypto.dart';

@Deprecated('eOASignature is deprecated. Replace with signUserOpHash.')
UserOperationMiddlewareFn eOASignature(EthPrivateKey credentials) {
  return (ctx) async {
    ctx.op.signature = bytesToHex(
      credentials.signPersonalMessageToUint8List(
        ctx.getUserOpHash(),
      ),
      include0x: true,
    );
  };
}

UserOperationMiddlewareFn signUserOpHash(EthPrivateKey credentials) {
  return (ctx) async {
    ctx.op.signature = bytesToHex(
      credentials.signPersonalMessageToUint8List(
        ctx.getUserOpHash(),
      ),
      include0x: true,
    );
  };
}
