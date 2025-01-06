import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_star/states/pokeapi_state.dart';

import '../../models/pokeapi.dart';
import '../repository/pokerepository.dart';
import '../../consts/consts_app.dart';

class PokeApiCubit extends Cubit<PokeApiState> {
  final PokemonRepository _repository;

  String _searchQuery = ''; // Requête de recherche pour filtrer les Pokémon.
  List<Pokemon> _allPokemon = []; // Liste complète de Pokémon.
  Pokemon? _pokemonActual; // Pokémon actuel sélectionné.
  Color? corPokemon; // Couleur du Pokémon actuel.
  int? positionActual; // Position actuelle du Pokémon.

  PokeApiCubit(this._repository) : super(PokeApiInitial());

  /// Récupère la liste des Pokémon depuis le dépôt.
  Future<void> fetchPokemonList() async {
    emit(PokeApiLoading());
    try {
      final pokeAPI = await _repository.fetchPokemonList();
      _allPokemon = pokeAPI.pokemon; // Stocke la liste complète des Pokémon.
      emit(PokeApiLoaded(pokeAPI: pokeAPI, filteredPokemonList: _allPokemon));
    } catch (e) {
      emit(PokeApiError(message: e.toString()));
    }
  }

  /// Met à jour la requête de recherche et émet un nouvel état filtré.
  void setSearchQuery(String query) {
    _searchQuery = query.trim().toLowerCase();
    if (state is PokeApiLoaded) {
      emit(PokeApiLoaded(
        pokeAPI: PokeAPI(pokemon: filteredPokemonList),
        filteredPokemonList: filteredPokemonList,
      ));
    }
  }

  /// Définit le Pokémon actuel et met à jour la couleur et la position.
  void setPokemonActual({required int index}) {
    _pokemonActual = _allPokemon[index];
    corPokemon = ConstsApp.getColorType(type: _pokemonActual!.type[0]);
    positionActual = index;
    emit(PokeApiLoaded(
      pokeAPI: PokeAPI(pokemon: _allPokemon),
      filteredPokemonList: filteredPokemonList,
    ));
  }

  /// Renvoie la liste des Pokémon filtrés selon la requête de recherche.
  List<Pokemon> get filteredPokemonList {
    if (_searchQuery.isEmpty) {
      return _allPokemon;
    }
    return _allPokemon
        .where((pokemon) =>
    pokemon.name.toLowerCase().contains(_searchQuery) ||
        pokemon.num.contains(_searchQuery))
        .toList();
  }

  /// Renvoie une image du Pokémon correspondant au numéro.
  Widget getImage({required String numero}) {
    try {
      final url =
          'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$numero.png';
      return Image.network(
        url,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error, size: 50, color: Colors.red);
        },
      );
    } catch (e) {
      return const Icon(Icons.error, size: 50, color: Colors.red);
    }
  }
}