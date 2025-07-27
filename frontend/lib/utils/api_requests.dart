import 'package:http/http.dart' as http;
import 'dart:convert';

const String baseUri = 'http://localhost:5000';

Future<dynamic> sendRequest({
  required String endpoint,
  required String method,
  Map<String, dynamic>? body,
  Map<String, String>? headers,
}) async {
  final uri = Uri.parse('$baseUri$endpoint');
  final completeHeaders = {
    'Content-Type': 'application/json',
    ...?headers,
  };

  late http.Response response;
  try {
    switch (method.toUpperCase()) {
      case 'GET':
        response = await http.get(uri, headers: completeHeaders);
        break;
      case 'POST':
        response = await http.post(
          uri,
          headers: completeHeaders,
          body: jsonEncode(body ?? {}),
        );
        break;
      case 'PUT':
        response = await http.put(
          uri,
          headers: completeHeaders,
          body: jsonEncode(body ?? {}),
        );
      case 'DELETE':
        response = await http.delete(
          uri,
          headers: completeHeaders,
          body: jsonEncode(body ?? {}),
        );
        break;
      default:
        throw Exception('Unsupported HTTP method: $method');
    }

    return jsonDecode(response.body);
  } catch (e) {
    rethrow;
  }
}
