import 'package:web3dart/web3dart.dart';

class UserOperationEventEventFilter extends FilterOptions {
  UserOperationEventEventFilter.events({
    required super.contract,
    required super.event,
    super.fromBlock,
    super.toBlock,
    required String userOpHash,
  }) : super.events() {
    if (userOpHash.isNotEmpty) {
      topics?.add([userOpHash]);
    }
  }
}
