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
  final List<Pokemon> _favoritePokemon = []; // Liste des Pokémon favoris.
  List<Pokemon> favoritePokemonList = [];
  String? selectedFavorite;
  Pokemon? _pokemonActual; // Pokémon actuel sélectionné.
  Color? corPokemon; // Couleur du Pokémon actuel.
  int? positionActual; // Position actuelle du Pokémon.
  String _selectedFilter = 'None'; // Filtre sélectionné pour trier les favoris.

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
        pokeAPI: PokeAPI(pokemon: _allPokemon),
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

  /// Ajoute ou retire un Pokémon des favoris.
  void toggleFavorite(Pokemon pokemon) {
    if (_favoritePokemon.contains(pokemon)) {
      _favoritePokemon.remove(pokemon);
    } else {
      _favoritePokemon.add(pokemon);
    }
    emit(PokeApiLoaded(
      pokeAPI: PokeAPI(pokemon: _allPokemon),
      filteredPokemonList: filteredFavoritePokemonList,
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

  /// Renvoie la liste des Pokémon favoris filtrés selon le filtre sélectionné.
  List<Pokemon> get filteredFavoritePokemonList {
    List<Pokemon> filteredList = _favoritePokemon;
    if (_selectedFilter == 'Type') {
      filteredList.sort((a, b) => a.type[0].compareTo(b.type[0]));
    } else if (_selectedFilter == 'Name') {
      filteredList.sort((a, b) => a.name.compareTo(b.name));
    } else if (_selectedFilter == 'Number') {
      filteredList.sort((a, b) => a.num.compareTo(b.num));
    }
    return filteredList;
  }

  /// Définit le filtre sélectionné et émet un nouvel état filtré.
  void setFilter(String value) {
    _selectedFilter = value;
    emit(PokeApiLoaded(
      pokeAPI: PokeAPI(pokemon: _allPokemon),
      filteredPokemonList: filteredFavoritePokemonList,
    ));
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

  void setSelectedFavorite(String? newValue) {
    selectedFavorite = newValue;
    emit(PokeApiLoaded(
      pokeAPI: state.pokeAPI,
      filteredPokemonList: state.filteredPokemonList,
      pokemonAtual: state.pokemonAtual,
      posicaoAtual: state.posicaoAtual,
      corPokemon: state.corPokemon,
      searchQuery: state.searchQuery,
    ));
  }

  /// Retourne le filtre sélectionné.
  String get selectedFilter => _selectedFilter;
}
