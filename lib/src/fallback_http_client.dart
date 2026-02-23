import 'package:http/http.dart' as http;

class FallbackHttpClient extends http.BaseClient {
  final http.Client _primaryClient = http.Client();
  final http.Client _fallbackClient = http.Client();
  final Uri? _fallbackRpcUri;

  String? _accessToken;

  FallbackHttpClient withAccessToken(String? accessToken) {
    _accessToken = accessToken;
    return this;
  }

  FallbackHttpClient(String? fallbackRpcUrl)
      : _fallbackRpcUri = Uri.tryParse(fallbackRpcUrl ?? '');

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    try {
      return await _primaryClient.send(request);
    } catch (e) {
      print('[FallbackHttpClient] Primary RPC failed: $e');
      try {
        if (_fallbackRpcUri == null) rethrow;
        final fallbackRequest =
            _copyRequest(request, _fallbackRpcUri, _accessToken);
        return await _fallbackClient.send(fallbackRequest);
      } catch (e2) {
        print('[FallbackHttpClient] Fallback RPC also failed: $e2');
        rethrow;
      }
    }
  }

  http.BaseRequest _copyRequest(
      http.BaseRequest request, Uri baseUri, String? accessToken) {
    final newRequest = http.Request(request.method, baseUri)
      ..headers.addAll({
        ...request.headers,
        ...{'authorization': 'Bearer $accessToken'}
      });
    if (request is http.Request) {
      newRequest.bodyBytes = request.bodyBytes;
    }
    return newRequest;
  }

  @override
  void close() {
    _primaryClient.close();
    _fallbackClient.close();
  }
}
