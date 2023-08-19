// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:web3dart/web3dart.dart' as _i1;
import 'dart:typed_data' as _i2;

final _contractAbi = _i1.ContractAbi.fromJson(
  '[{"inputs":[],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"wallet","type":"address"},{"indexed":true,"internalType":"address","name":"owner","type":"address"},{"indexed":false,"internalType":"uint256","name":"index","type":"uint256"}],"name":"AccountCreation","type":"event"},{"inputs":[],"name":"accountCreationCode","outputs":[{"internalType":"bytes","name":"","type":"bytes"}],"stateMutability":"pure","type":"function"},{"inputs":[],"name":"accountImplementation","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"contract IEntryPoint","name":"entryPoint","type":"address"},{"internalType":"address","name":"owner","type":"address"},{"internalType":"uint256","name":"index","type":"uint256"}],"name":"createAccount","outputs":[{"internalType":"address","name":"ret","type":"address"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"contract IEntryPoint","name":"entryPoint","type":"address"},{"internalType":"address","name":"owner","type":"address"},{"internalType":"uint256","name":"index","type":"uint256"}],"name":"getAddress","outputs":[{"internalType":"address","name":"proxy","type":"address"}],"stateMutability":"view","type":"function"}]',
  'EtherspotWalletFactory',
);

class EtherspotWalletFactory extends _i1.GeneratedContract {
  EtherspotWalletFactory({
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

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i2.Uint8List> accountCreationCode({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, '31c884df'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as _i2.Uint8List);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i1.EthereumAddress> accountImplementation(
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, '11464fbe'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as _i1.EthereumAddress);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> createAccount(
    _i1.EthereumAddress entryPoint,
    _i1.EthereumAddress owner,
    BigInt index, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, '1230aea2'));
    final params = [
      entryPoint,
      owner,
      index,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i1.EthereumAddress> getAddress(
    _i1.EthereumAddress entryPoint,
    _i1.EthereumAddress owner,
    BigInt index, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[4];
    assert(checkSignature(function, '08a6354e'));
    final params = [
      entryPoint,
      owner,
      index,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as _i1.EthereumAddress);
  }

  /// Returns a live stream of all AccountCreation events emitted by this contract.
  Stream<AccountCreation> accountCreationEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('AccountCreation');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return AccountCreation(
        decoded,
        result,
      );
    });
  }
}

class AccountCreation {
  AccountCreation(
    List<dynamic> response,
    this.event,
  )   : wallet = (response[0] as _i1.EthereumAddress),
        owner = (response[1] as _i1.EthereumAddress),
        index = (response[2] as BigInt);

  final _i1.EthereumAddress wallet;

  final _i1.EthereumAddress owner;

  final BigInt index;

  final _i1.FilterEvent event;
}
