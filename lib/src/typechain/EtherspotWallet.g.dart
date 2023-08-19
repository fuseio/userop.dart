// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:web3dart/web3dart.dart' as _i1;
import 'dart:typed_data' as _i2;

final _contractAbi = _i1.ContractAbi.fromJson(
  '[{"inputs":[],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"previousAdmin","type":"address"},{"indexed":false,"internalType":"address","name":"newAdmin","type":"address"}],"name":"AdminChanged","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"beacon","type":"address"}],"name":"BeaconUpgraded","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"oldEntryPoint","type":"address"},{"indexed":false,"internalType":"address","name":"newEntryPoint","type":"address"}],"name":"EntryPointChanged","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"contract IEntryPoint","name":"entryPoint","type":"address"},{"indexed":true,"internalType":"address","name":"owner","type":"address"}],"name":"EtherspotWalletInitialized","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"from","type":"address"},{"indexed":true,"internalType":"uint256","name":"amount","type":"uint256"}],"name":"EtherspotWalletReceived","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"newGuardian","type":"address"}],"name":"GuardianAdded","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"removedGuardian","type":"address"}],"name":"GuardianRemoved","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint8","name":"version","type":"uint8"}],"name":"Initialized","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"newOwner","type":"address"}],"name":"OwnerAdded","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"removedOwner","type":"address"}],"name":"OwnerRemoved","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"proposalId","type":"uint256"}],"name":"ProposalDiscarded","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"proposalId","type":"uint256"},{"indexed":false,"internalType":"address","name":"newOwnerProposed","type":"address"},{"indexed":false,"internalType":"address","name":"proposer","type":"address"}],"name":"ProposalSubmitted","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"proposalId","type":"uint256"},{"indexed":false,"internalType":"address","name":"newOwnerProposed","type":"address"},{"indexed":false,"internalType":"uint256","name":"guardiansApproved","type":"uint256"}],"name":"QuorumNotReached","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"implementation","type":"address"}],"name":"Upgraded","type":"event"},{"inputs":[],"name":"addDeposit","outputs":[],"stateMutability":"payable","type":"function"},{"inputs":[{"internalType":"address","name":"_newGuardian","type":"address"}],"name":"addGuardian","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_newOwner","type":"address"}],"name":"addOwner","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"discardCurrentProposal","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"entryPoint","outputs":[{"internalType":"contract IEntryPoint","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"dest","type":"address"},{"internalType":"uint256","name":"value","type":"uint256"},{"internalType":"bytes","name":"func","type":"bytes"}],"name":"execute","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address[]","name":"dest","type":"address[]"},{"internalType":"uint256[]","name":"value","type":"uint256[]"},{"internalType":"bytes[]","name":"func","type":"bytes[]"}],"name":"executeBatch","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"getDeposit","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getNonce","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"_proposalId","type":"uint256"}],"name":"getProposal","outputs":[{"internalType":"address","name":"ownerProposed_","type":"address"},{"internalType":"uint256","name":"approvalCount_","type":"uint256"},{"internalType":"address[]","name":"guardiansApproved_","type":"address[]"},{"internalType":"bool","name":"resolved_","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"_proposalId","type":"uint256"}],"name":"guardianCosign","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"guardianCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_newOwner","type":"address"}],"name":"guardianPropose","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"contract IEntryPoint","name":"anEntryPoint","type":"address"},{"internalType":"address","name":"anOwner","type":"address"}],"name":"initialize","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_address","type":"address"}],"name":"isGuardian","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_address","type":"address"}],"name":"isOwner","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"hash","type":"bytes32"},{"internalType":"bytes","name":"signature","type":"bytes"}],"name":"isValidSignature","outputs":[{"internalType":"bytes4","name":"magicValue","type":"bytes4"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"},{"internalType":"address","name":"","type":"address"},{"internalType":"uint256[]","name":"","type":"uint256[]"},{"internalType":"uint256[]","name":"","type":"uint256[]"},{"internalType":"bytes","name":"","type":"bytes"}],"name":"onERC1155BatchReceived","outputs":[{"internalType":"bytes4","name":"","type":"bytes4"}],"stateMutability":"pure","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"},{"internalType":"address","name":"","type":"address"},{"internalType":"uint256","name":"","type":"uint256"},{"internalType":"uint256","name":"","type":"uint256"},{"internalType":"bytes","name":"","type":"bytes"}],"name":"onERC1155Received","outputs":[{"internalType":"bytes4","name":"","type":"bytes4"}],"stateMutability":"pure","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"},{"internalType":"address","name":"","type":"address"},{"internalType":"uint256","name":"","type":"uint256"},{"internalType":"bytes","name":"","type":"bytes"}],"name":"onERC721Received","outputs":[{"internalType":"bytes4","name":"","type":"bytes4"}],"stateMutability":"pure","type":"function"},{"inputs":[],"name":"ownerCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"proposalId","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"proxiableUUID","outputs":[{"internalType":"bytes32","name":"","type":"bytes32"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_guardian","type":"address"}],"name":"removeGuardian","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_owner","type":"address"}],"name":"removeOwner","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"bytes4","name":"interfaceId","type":"bytes4"}],"name":"supportsInterface","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"},{"internalType":"address","name":"","type":"address"},{"internalType":"address","name":"","type":"address"},{"internalType":"uint256","name":"","type":"uint256"},{"internalType":"bytes","name":"","type":"bytes"},{"internalType":"bytes","name":"","type":"bytes"}],"name":"tokensReceived","outputs":[],"stateMutability":"pure","type":"function"},{"inputs":[{"internalType":"address","name":"_newEntryPoint","type":"address"}],"name":"updateEntryPoint","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"newImplementation","type":"address"}],"name":"upgradeTo","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"newImplementation","type":"address"},{"internalType":"bytes","name":"data","type":"bytes"}],"name":"upgradeToAndCall","outputs":[],"stateMutability":"payable","type":"function"},{"inputs":[{"components":[{"internalType":"address","name":"sender","type":"address"},{"internalType":"uint256","name":"nonce","type":"uint256"},{"internalType":"bytes","name":"initCode","type":"bytes"},{"internalType":"bytes","name":"callData","type":"bytes"},{"internalType":"uint256","name":"callGasLimit","type":"uint256"},{"internalType":"uint256","name":"verificationGasLimit","type":"uint256"},{"internalType":"uint256","name":"preVerificationGas","type":"uint256"},{"internalType":"uint256","name":"maxFeePerGas","type":"uint256"},{"internalType":"uint256","name":"maxPriorityFeePerGas","type":"uint256"},{"internalType":"bytes","name":"paymasterAndData","type":"bytes"},{"internalType":"bytes","name":"signature","type":"bytes"}],"internalType":"struct UserOperation","name":"userOp","type":"tuple"},{"internalType":"bytes32","name":"userOpHash","type":"bytes32"},{"internalType":"uint256","name":"missingAccountFunds","type":"uint256"}],"name":"validateUserOp","outputs":[{"internalType":"uint256","name":"validationData","type":"uint256"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address payable","name":"withdrawAddress","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"withdrawDepositTo","outputs":[],"stateMutability":"nonpayable","type":"function"},{"stateMutability":"payable","type":"receive"}]',
  'EtherspotWallet',
);

class EtherspotWallet extends _i1.GeneratedContract {
  EtherspotWallet({
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
  Future<String> addDeposit({
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, '4a58db19'));
    final params = [];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> addGuardian(
    _i1.EthereumAddress _newGuardian, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, 'a526d83b'));
    final params = [_newGuardian];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> addOwner(
    _i1.EthereumAddress _newOwner, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, '7065cb48'));
    final params = [_newOwner];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> discardCurrentProposal({
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[4];
    assert(checkSignature(function, 'c3db8838'));
    final params = [];
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
  Future<_i1.EthereumAddress> entryPoint({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[5];
    assert(checkSignature(function, 'b0d691fe'));
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
  Future<String> execute(
    _i1.EthereumAddress dest,
    BigInt value,
    _i2.Uint8List func, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[6];
    assert(checkSignature(function, 'b61d27f6'));
    final params = [
      dest,
      value,
      func,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> executeBatch(
    List<_i1.EthereumAddress> dest,
    List<BigInt> value,
    List<_i2.Uint8List> func, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[7];
    assert(checkSignature(function, '47e1da2a'));
    final params = [
      dest,
      value,
      func,
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
  Future<BigInt> getDeposit({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[8];
    assert(checkSignature(function, 'c399ec88'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> getNonce({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[9];
    assert(checkSignature(function, 'd087d288'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<GetProposal> getProposal(
    BigInt _proposalId, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[10];
    assert(checkSignature(function, 'c7f758a8'));
    final params = [_proposalId];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return GetProposal(response);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> guardianCosign(
    BigInt _proposalId, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[11];
    assert(checkSignature(function, '201e41a2'));
    final params = [_proposalId];
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
  Future<BigInt> guardianCount({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[12];
    assert(checkSignature(function, '54387ad7'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> guardianPropose(
    _i1.EthereumAddress _newOwner, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[13];
    assert(checkSignature(function, '7dcab4ce'));
    final params = [_newOwner];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> initialize(
    _i1.EthereumAddress anEntryPoint,
    _i1.EthereumAddress anOwner, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[14];
    assert(checkSignature(function, '485cc955'));
    final params = [
      anEntryPoint,
      anOwner,
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
  Future<bool> isGuardian(
    _i1.EthereumAddress _address, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[15];
    assert(checkSignature(function, '0c68ba21'));
    final params = [_address];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as bool);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<bool> isOwner(
    _i1.EthereumAddress _address, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[16];
    assert(checkSignature(function, '2f54bf6e'));
    final params = [_address];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as bool);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i2.Uint8List> isValidSignature(
    _i2.Uint8List hash,
    _i2.Uint8List signature, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[17];
    assert(checkSignature(function, '1626ba7e'));
    final params = [
      hash,
      signature,
    ];
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
  Future<_i2.Uint8List> onERC1155BatchReceived(
    _i1.EthereumAddress $param17,
    _i1.EthereumAddress $param18,
    List<BigInt> $param19,
    List<BigInt> $param20,
    _i2.Uint8List $param21, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[18];
    assert(checkSignature(function, 'bc197c81'));
    final params = [
      $param17,
      $param18,
      $param19,
      $param20,
      $param21,
    ];
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
  Future<_i2.Uint8List> onERC1155Received(
    _i1.EthereumAddress $param22,
    _i1.EthereumAddress $param23,
    BigInt $param24,
    BigInt $param25,
    _i2.Uint8List $param26, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[19];
    assert(checkSignature(function, 'f23a6e61'));
    final params = [
      $param22,
      $param23,
      $param24,
      $param25,
      $param26,
    ];
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
  Future<_i2.Uint8List> onERC721Received(
    _i1.EthereumAddress $param27,
    _i1.EthereumAddress $param28,
    BigInt $param29,
    _i2.Uint8List $param30, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[20];
    assert(checkSignature(function, '150b7a02'));
    final params = [
      $param27,
      $param28,
      $param29,
      $param30,
    ];
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
  Future<BigInt> ownerCount({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[21];
    assert(checkSignature(function, '0db02622'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> proposalId({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[22];
    assert(checkSignature(function, '2dfca445'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i2.Uint8List> proxiableUUID({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[23];
    assert(checkSignature(function, '52d1902d'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as _i2.Uint8List);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> removeGuardian(
    _i1.EthereumAddress _guardian, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[24];
    assert(checkSignature(function, '71404156'));
    final params = [_guardian];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> removeOwner(
    _i1.EthereumAddress _owner, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[25];
    assert(checkSignature(function, '173825d9'));
    final params = [_owner];
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
  Future<bool> supportsInterface(
    _i2.Uint8List interfaceId, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[26];
    assert(checkSignature(function, '01ffc9a7'));
    final params = [interfaceId];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as bool);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<void> tokensReceived(
    _i1.EthereumAddress $param34,
    _i1.EthereumAddress $param35,
    _i1.EthereumAddress $param36,
    BigInt $param37,
    _i2.Uint8List $param38,
    _i2.Uint8List $param39, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[27];
    assert(checkSignature(function, '0023de29'));
    final params = [
      $param34,
      $param35,
      $param36,
      $param37,
      $param38,
      $param39,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> updateEntryPoint(
    _i1.EthereumAddress _newEntryPoint, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[28];
    assert(checkSignature(function, '1b71bb6e'));
    final params = [_newEntryPoint];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> upgradeTo(
    _i1.EthereumAddress newImplementation, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[29];
    assert(checkSignature(function, '3659cfe6'));
    final params = [newImplementation];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> upgradeToAndCall(
    _i1.EthereumAddress newImplementation,
    _i2.Uint8List data, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[30];
    assert(checkSignature(function, '4f1ef286'));
    final params = [
      newImplementation,
      data,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> validateUserOp(
    dynamic userOp,
    _i2.Uint8List userOpHash,
    BigInt missingAccountFunds, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[31];
    assert(checkSignature(function, '3a871cdd'));
    final params = [
      userOp,
      userOpHash,
      missingAccountFunds,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> withdrawDepositTo(
    _i1.EthereumAddress withdrawAddress,
    BigInt amount, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[32];
    assert(checkSignature(function, '4d44560d'));
    final params = [
      withdrawAddress,
      amount,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// Returns a live stream of all AdminChanged events emitted by this contract.
  Stream<AdminChanged> adminChangedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('AdminChanged');
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
      return AdminChanged(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all BeaconUpgraded events emitted by this contract.
  Stream<BeaconUpgraded> beaconUpgradedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('BeaconUpgraded');
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
      return BeaconUpgraded(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all EntryPointChanged events emitted by this contract.
  Stream<EntryPointChanged> entryPointChangedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('EntryPointChanged');
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
      return EntryPointChanged(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all EtherspotWalletInitialized events emitted by this contract.
  Stream<EtherspotWalletInitialized> etherspotWalletInitializedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('EtherspotWalletInitialized');
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
      return EtherspotWalletInitialized(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all EtherspotWalletReceived events emitted by this contract.
  Stream<EtherspotWalletReceived> etherspotWalletReceivedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('EtherspotWalletReceived');
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
      return EtherspotWalletReceived(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all GuardianAdded events emitted by this contract.
  Stream<GuardianAdded> guardianAddedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('GuardianAdded');
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
      return GuardianAdded(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all GuardianRemoved events emitted by this contract.
  Stream<GuardianRemoved> guardianRemovedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('GuardianRemoved');
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
      return GuardianRemoved(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all Initialized events emitted by this contract.
  Stream<Initialized> initializedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('Initialized');
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
      return Initialized(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all OwnerAdded events emitted by this contract.
  Stream<OwnerAdded> ownerAddedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('OwnerAdded');
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
      return OwnerAdded(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all OwnerRemoved events emitted by this contract.
  Stream<OwnerRemoved> ownerRemovedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('OwnerRemoved');
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
      return OwnerRemoved(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all ProposalDiscarded events emitted by this contract.
  Stream<ProposalDiscarded> proposalDiscardedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('ProposalDiscarded');
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
      return ProposalDiscarded(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all ProposalSubmitted events emitted by this contract.
  Stream<ProposalSubmitted> proposalSubmittedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('ProposalSubmitted');
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
      return ProposalSubmitted(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all QuorumNotReached events emitted by this contract.
  Stream<QuorumNotReached> quorumNotReachedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('QuorumNotReached');
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
      return QuorumNotReached(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all Upgraded events emitted by this contract.
  Stream<Upgraded> upgradedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('Upgraded');
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
      return Upgraded(
        decoded,
        result,
      );
    });
  }
}

class GetProposal {
  GetProposal(List<dynamic> response)
      : ownerProposed = (response[0] as _i1.EthereumAddress),
        approvalCount = (response[1] as BigInt),
        guardiansApproved =
            (response[2] as List<dynamic>).cast<_i1.EthereumAddress>(),
        resolved = (response[3] as bool);

  final _i1.EthereumAddress ownerProposed;

  final BigInt approvalCount;

  final List<_i1.EthereumAddress> guardiansApproved;

  final bool resolved;
}

class AdminChanged {
  AdminChanged(
    List<dynamic> response,
    this.event,
  )   : previousAdmin = (response[0] as _i1.EthereumAddress),
        newAdmin = (response[1] as _i1.EthereumAddress);

  final _i1.EthereumAddress previousAdmin;

  final _i1.EthereumAddress newAdmin;

  final _i1.FilterEvent event;
}

class BeaconUpgraded {
  BeaconUpgraded(
    List<dynamic> response,
    this.event,
  ) : beacon = (response[0] as _i1.EthereumAddress);

  final _i1.EthereumAddress beacon;

  final _i1.FilterEvent event;
}

class EntryPointChanged {
  EntryPointChanged(
    List<dynamic> response,
    this.event,
  )   : oldEntryPoint = (response[0] as _i1.EthereumAddress),
        newEntryPoint = (response[1] as _i1.EthereumAddress);

  final _i1.EthereumAddress oldEntryPoint;

  final _i1.EthereumAddress newEntryPoint;

  final _i1.FilterEvent event;
}

class EtherspotWalletInitialized {
  EtherspotWalletInitialized(
    List<dynamic> response,
    this.event,
  )   : entryPoint = (response[0] as _i1.EthereumAddress),
        owner = (response[1] as _i1.EthereumAddress);

  final _i1.EthereumAddress entryPoint;

  final _i1.EthereumAddress owner;

  final _i1.FilterEvent event;
}

class EtherspotWalletReceived {
  EtherspotWalletReceived(
    List<dynamic> response,
    this.event,
  )   : from = (response[0] as _i1.EthereumAddress),
        amount = (response[1] as BigInt);

  final _i1.EthereumAddress from;

  final BigInt amount;

  final _i1.FilterEvent event;
}

class GuardianAdded {
  GuardianAdded(
    List<dynamic> response,
    this.event,
  ) : newGuardian = (response[0] as _i1.EthereumAddress);

  final _i1.EthereumAddress newGuardian;

  final _i1.FilterEvent event;
}

class GuardianRemoved {
  GuardianRemoved(
    List<dynamic> response,
    this.event,
  ) : removedGuardian = (response[0] as _i1.EthereumAddress);

  final _i1.EthereumAddress removedGuardian;

  final _i1.FilterEvent event;
}

class Initialized {
  Initialized(
    List<dynamic> response,
    this.event,
  ) : version = (response[0] as BigInt);

  final BigInt version;

  final _i1.FilterEvent event;
}

class OwnerAdded {
  OwnerAdded(
    List<dynamic> response,
    this.event,
  ) : newOwner = (response[0] as _i1.EthereumAddress);

  final _i1.EthereumAddress newOwner;

  final _i1.FilterEvent event;
}

class OwnerRemoved {
  OwnerRemoved(
    List<dynamic> response,
    this.event,
  ) : removedOwner = (response[0] as _i1.EthereumAddress);

  final _i1.EthereumAddress removedOwner;

  final _i1.FilterEvent event;
}

class ProposalDiscarded {
  ProposalDiscarded(
    List<dynamic> response,
    this.event,
  ) : proposalId = (response[0] as BigInt);

  final BigInt proposalId;

  final _i1.FilterEvent event;
}

class ProposalSubmitted {
  ProposalSubmitted(
    List<dynamic> response,
    this.event,
  )   : proposalId = (response[0] as BigInt),
        newOwnerProposed = (response[1] as _i1.EthereumAddress),
        proposer = (response[2] as _i1.EthereumAddress);

  final BigInt proposalId;

  final _i1.EthereumAddress newOwnerProposed;

  final _i1.EthereumAddress proposer;

  final _i1.FilterEvent event;
}

class QuorumNotReached {
  QuorumNotReached(
    List<dynamic> response,
    this.event,
  )   : proposalId = (response[0] as BigInt),
        newOwnerProposed = (response[1] as _i1.EthereumAddress),
        guardiansApproved = (response[2] as BigInt);

  final BigInt proposalId;

  final _i1.EthereumAddress newOwnerProposed;

  final BigInt guardiansApproved;

  final _i1.FilterEvent event;
}

class Upgraded {
  Upgraded(
    List<dynamic> response,
    this.event,
  ) : implementation = (response[0] as _i1.EthereumAddress);

  final _i1.EthereumAddress implementation;

  final _i1.FilterEvent event;
}
