import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

mixin ApiServiceMixin {
  final String _url = 'https://jsonplaceholder.typicode.com/';

  Future<List<dynamic>> get(String url) async {
    final response = await http.get('$_url$url');
    if (response.statusCode == HttpStatus.ok) {
      return jsonDecode(response.body);
    } else {
      throw HttpException("Cannot load data");
    }
  }
}
