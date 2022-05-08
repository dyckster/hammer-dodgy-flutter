import 'dart:convert';

import 'package:hammer_dodgy/models/api/MovieApiModel.dart';
import 'package:http/http.dart' as http;

class GetMovieDataUseCase {
  Future<MovieApiModel> fetchMovie(String id, String language) async {
    final response = await http.get(Uri.parse(
        "http://api.dyckster.com:8080/get-movie?id=$id&language=$language"));

    if (response.statusCode == 200) {
      return MovieApiModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load a movie");
    }
  }
}
