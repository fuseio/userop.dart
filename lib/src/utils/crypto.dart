import 'dart:typed_data';

String hexZeroPad(String value, num length) {
  while (value.length < 2 * length + 2) {
    value = '0x0${value.substring(2)}';
  }
  return value;
}

typedef BytesLike = dynamic; // This can be either String or Uint8List in Dart

Uint8List _getBytes(BytesLike value, [String? name, bool? copy = false]) {
  if (value is Uint8List) {
    if (copy!) {
      return Uint8List.fromList(value);
    }
    return value;
  }

  if (value is BigInt) {
    if (copy!) {
      return Uint8List.fromList(value.toRadixString(16).codeUnits);
    }
    return Uint8List.fromList(value.toRadixString(16).codeUnits);
  }

  if (value is String &&
      RegExp(r'^0x([0-9a-f][0-9a-f])*$', caseSensitive: false)
          .hasMatch(value)) {
    final result = Uint8List((value.length - 2) ~/ 2);
    int offset = 2;
    for (var i = 0; i < result.length; i++) {
      result[i] = int.parse(value.substring(offset, offset + 2), radix: 16);
      offset += 2;
    }
    return result;
  }

  throw ArgumentError("invalid BytesLike value ${name ?? "value"}: $value");
}

Uint8List getBytes(BytesLike value, [String? name]) {
  return _getBytes(value, name, false);
}

final String hexCharacters = "0123456789abcdef";

String hexlify(BytesLike data) {
  final bytes = getBytes(data);

  var result = "0x";
  for (var i = 0; i < bytes.length; i++) {
    final v = bytes[i];
    result += hexCharacters[(v & 0xf0) >> 4] + hexCharacters[v & 0x0f];
  }
  return result;
}
