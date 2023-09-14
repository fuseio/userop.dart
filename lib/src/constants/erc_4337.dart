// ignore_for_file: constant_identifier_names

/// A class that encapsulates constants related to the ERC-4337 protocol.
class ERC4337 {
  /// A private constructor to prevent the instantiation of this class.
  ERC4337._();

  /// The address for the EntryPoint contract as per the ERC-4337 protocol.
  static const ENTRY_POINT = "0x5FF137D4b0FDCD49DcA30c7CF57E578a026d2789";

  /// The address for the SimpleAccountFactory contract as per the ERC-4337 protocol.
  static const SIMPLE_ACCOUNT_FACTORY =
      "0x9406Cc6185a346906296840746125a0E44976454";

  /// The address for the EtherspotWalletFactory contract as per the ERC-4337 protocol.
  static const ETHERSPOT_WALLET_FACTORY =
      "0x7f6d8F107fE8551160BD5351d5F1514A6aD5d40E";
}
