import 'dart:convert';

import 'package:http/http.dart' as http;

// Ступень работы с API, тут мы обращаемся к апи, получаем json, декодируем и возвращаем докодированный json.
class ApiClient {
  Future<List<dynamic>> getUsers() async {
    final res = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    final List<dynamic> data = json.decode(res.body);
    return data;
  }

  getUser(int id) async {
    final res = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users/${id}'));

    final data = json.decode(res.body);
    return data;
  }
}