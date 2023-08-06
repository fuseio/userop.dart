// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:web3dart/web3dart.dart' as _i1;
import 'dart:typed_data' as _i2;

final _contractAbi = _i1.ContractAbi.fromJson(
  '[{"inputs":[],"stateMutability":"nonpayable","type":"constructor"},{"inputs":[{"internalType":"bytes","name":"transactions","type":"bytes"}],"name":"multiSend","outputs":[],"stateMutability":"payable","type":"function"}]',
  'Multisend',
);

class Multisend extends _i1.GeneratedContract {
  Multisend({
    required _i1.EthereumAddress address,
    required _i1.Web3Client client,
    int? chainId,
  }) : super(
          _i1.DeployedContract(
            _contractAbi,
            address,
          ),
          client,
          chainId,
        );

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> multiSend(
    _i2.Uint8List transactions, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, '8d80ff0a'));
    final params = [transactions];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }
}
