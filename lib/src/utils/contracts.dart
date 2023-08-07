import 'dart:typed_data';

import 'package:web3dart/web3dart.dart';

import 'abis.dart';

/// A utility class providing methods to interact with contracts.
///
/// `ContractsHelper` simplifies tasks such as reading from a contract,
/// encoding data for contract calls, and signing off-chain transactions.
class ContractsHelper {
  /// Reads data from a deployed contract using the specified function and parameters.
  ///
  /// [client] is the web3 client instance to interact with the Fuse network.
  /// [contractName] is the name of the contract.
  /// [contractAddress] is the address of the deployed contract.
  /// [functionName] is the name of the function to be called.
  /// [params] is a list of parameters to be passed to the function.
  /// [jsonInterface] is an optional JSON string representing the contract ABI.
  ///
  /// Returns a `Future` that resolves to a list of values returned by the contract function.
  static Future<List<dynamic>> readFromContract(
    Web3Client client,
    String contractName,
    String contractAddress,
    String functionName,
    List<dynamic> params, {
    String? jsonInterface,
  }) async {
    final DeployedContract contract = _getDeployedContract(
      contractName,
      contractAddress,
      jsonInterface: jsonInterface,
    );
    return client.call(
      contract: contract,
      function: contract.function(functionName),
      params: params,
    );
  }

  /// Retrieves the deployed contract instance using the contract name and address.
  ///
  /// [contractName] is the name of the contract.
  /// [contractAddress] is the address of the deployed contract.
  /// [jsonInterface] is an optional JSON string representing the contract ABI.
  ///
  /// Returns a `DeployedContract` instance.
  static DeployedContract _getDeployedContract(
    String contractName,
    String contractAddress, {
    String? jsonInterface,
  }) {
    final String abi = jsonInterface ?? ABI.get(contractName);
    final ContractAbi contractAbi = ContractAbi.fromJson(abi, contractName);
    final EthereumAddress address = EthereumAddress.fromHex(contractAddress);
    final DeployedContract contract = DeployedContract(
      contractAbi,
      address,
    );
    return contract;
  }

  /// Encodes data for a contract call using the specified function and parameters.
  ///
  /// [contractName] is the name of the contract.
  /// [contractAddress] is the address of the deployed contract.
  /// [functionName] is the name of the function to be called.
  /// [params] is a list of parameters to be passed to the function.
  /// [jsonInterface] is an optional JSON string representing the contract ABI.
  /// [include0x] is a flag to include the '0x' prefix in the encoded data.
  /// [forcePadLength] is an optional integer to force padding of the output data.
  /// [padToEvenLength] is a flag to pad the output data to an even length.
  ///
  /// Returns a encoded data as a Uint8List.
  static Uint8List encodedDataForContractCall(
    String contractName,
    String contractAddress,
    String functionName,
    List<dynamic> params, {
    String? jsonInterface,
    bool include0x = false,
    int? forcePadLength,
    bool padToEvenLength = false,
  }) {
    final DeployedContract contract = _getDeployedContract(
      contractName,
      contractAddress,
      jsonInterface: jsonInterface,
    );
    return contract.function(functionName).encodeCall(params);
  }
}
