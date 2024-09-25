import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/meme.dart';

class ApiService {
  final String apiUrl = 'https://api.imgflip.com/get_memes';

  Future<List<Meme>> fetchMemes() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List memes = data['data']['memes'];
      return memes.map((json) => Meme.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load memes');
    }
  }
}
