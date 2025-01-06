import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:poke_star/models/pokeapi.dart';

class PokemonRepository {
  final String apiUrl;

  PokemonRepository({required this.apiUrl});

  /// Récupère la liste des Pokémon depuis l'API.
  Future<PokeAPI> fetchPokemonList() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return PokeAPI.fromJson(data);
      } else {
        throw Exception('Erreur de chargement des données (${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Erreur lors de la connexion à l\'API : $e');
    }
  }
}

