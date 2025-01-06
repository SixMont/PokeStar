import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:poke_star/models/pokeapiv2.dart';
import 'package:poke_star/models/specie.dart';

class PokemonRepositoryV2 {
  final String apiUrl1;
  final String apiUrl2;

  PokemonRepositoryV2({required this.apiUrl1, required this.apiUrl2});

  Future<PokeApiV2> fetchPokemonV2(String name) async {
    try {
      final response = await http.get(Uri.parse(apiUrl1 + name.toLowerCase()));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return PokeApiV2.fromJson(data);
      } else {
        throw Exception('Erreur de chargement des données (${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Erreur lors de la connexion à l\'API : $e');
    }
  }

  Future<Specie> fetchPokemonSpecie(String name) async {
    try {
      final response = await http.get(Uri.parse(apiUrl2 + name.toLowerCase()));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Specie.fromJson(data);
      } else {
        throw Exception('Erreur de chargement des données (${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Erreur lors de la connexion à l\'API : $e');
    }
  }
}