import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  static const String _adminSecret = '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  Future<List<dynamic>> fetchBlogs() async {
    try {
      final response = await http.get(Uri.parse(_url), headers: {
        'x-hasura-admin-secret': _adminSecret,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['blogs']; // Assuming 'blogs' is the key containing the list
      } else {
        throw Exception('Failed to load blogs');
      }
    } catch (e) {
      throw Exception('Failed to load blogs: $e');
    }
  }
}
