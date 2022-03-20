import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:exampleevent/src/models/the_simpsons_model.dart';

class TheSimpsonsProvider extends ChangeNotifier {
  Future<List<TheSimpsonsModels>> fetchTheSimpsons(int num) async {
    final response = await http.get(
        Uri.parse("https://thesimpsonsquoteapi.glitch.me/quotes?count=$num"));
    if (response.statusCode == 200) {
      return decodeSimpsons(response.body);
    } else {
      throw Exception('Unable to fetch data from the REST API');
    }
  }

  List<TheSimpsonsModels> decodeSimpsons(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<TheSimpsonsModels>((json) => TheSimpsonsModels.fromMap(json))
        .toList();
  }
}
