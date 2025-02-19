import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_star/states/pokeapi_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../consts/consts_app.dart';
import '../../models/pokeapi.dart';
import '../repository/pokerepository.dart';

class PokeApiCubit extends Cubit<PokeApiState> {
  final PokemonRepository _repository;
  bool useAlternateUrl = false;

  String _searchQuery = ''; // Search query to filter Pokémon.
  List<Pokemon> _allPokemon = []; // Complete list of Pokémon.
  List<Pokemon> _favoritePokemon = []; // List of favorite Pokémon.
  String? selectedFavorite; // Currently selected favorite Pokémon.
  Pokemon? _pokemonActual; // Currently selected Pokémon.
  Color? corPokemon; // Color of the current Pokémon.
  int? positionActual; // Current position of the Pokémon.
  final String _selectedFilter = 'None'; // Selected filter to sort favorites.

  PokeApiCubit(this._repository) : super(PokeApiInitial()) {
    _loadPreferences();
  }

  // Load preferences from shared preferences.
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    useAlternateUrl =
        prefs.getString('selectedImageType') == 'Image Pokemon GO';
    emit(PokeApiLoaded(
      pokeAPI: PokeAPI(pokemon: _allPokemon),
      filteredPokemonList: filteredPokemonList,
    ));
  }

  // Save preferences to shared preferences.
  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedImageType',
        useAlternateUrl ? 'Image Pokemon GO' : 'Original Image');
  }


  /// Return the position of the current Pokémon.
  Pokemon? get pokemonActual => _pokemonActual;

  /// Return the total number of Pokémon.
  int get totalPokemon => _allPokemon.length;

  /// Return the list of favorite Pokémon.
  List<Pokemon> get favoritePokemon => _favoritePokemon;

  // Fetch the list of Pokémon from the repository.
  Future<void> fetchPokemonList() async {
    emit(PokeApiLoading());
    try {
      final pokeAPI = await _repository.fetchPokemonList();
      _allPokemon = pokeAPI.pokemon;
      await _loadFavorites();
      emit(PokeApiLoaded(pokeAPI: pokeAPI, filteredPokemonList: _allPokemon));
    } catch (e) {
      emit(PokeApiError(message: e.toString()));
    }
  }

  // Update the search query and emit a new filtered state.
  void setSearchQuery(String query) {
    _searchQuery = query.trim().toLowerCase();
    if (state is PokeApiLoaded) {
      emit(PokeApiLoaded(
        pokeAPI: PokeAPI(pokemon: _allPokemon),
        filteredPokemonList: filteredPokemonList,
      ));
    }
  }

  // Set the current Pokémon and update its color and position.
  void setPokemonActual({required int index}) {
    _pokemonActual = _allPokemon[index];
    corPokemon = ConstsApp.getColorType(type: _pokemonActual!.type[0]);
    positionActual = index;
    emit(PokeApiLoaded(
      pokeAPI: PokeAPI(pokemon: _allPokemon),
      filteredPokemonList: filteredPokemonList,
    ));
  }

  // Add or remove a Pokémon from favorites.
  void toggleFavorite(Pokemon pokemon) async {
    if (_favoritePokemon.contains(pokemon)) {
      _favoritePokemon.remove(pokemon);
    } else {
      _favoritePokemon.add(pokemon);
    }
    await _saveFavorites();
    emit(PokeApiLoaded(
      pokeAPI: PokeAPI(pokemon: _allPokemon),
      filteredPokemonList: _allPokemon,
    ));
  }

  // Return the list of Pokémon filtered by the search query.
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

  // Return the list of favorite Pokémon filtered by the selected filter.
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

  // Toggle the image URL between the original and alternate.
  void toggleImageUrl() {
    useAlternateUrl = !useAlternateUrl;
    _savePreferences();
    emit(PokeApiLoaded(
      pokeAPI: PokeAPI(pokemon: _allPokemon),
      filteredPokemonList: filteredPokemonList,
    ));
  }

  // Return an image of the Pokémon corresponding to the number.
  Widget getImage({required String numero}) {
    try {
      final url = useAlternateUrl
          ? 'http://www.serebii.net/pokemongo/pokemon/$numero.png'
          : 'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$numero.png';
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

  // Set the selected favorite Pokémon.
  void setSelectedFavorite(String? newValue) {
    selectedFavorite = newValue;
    emit(PokeApiLoaded(
      pokeAPI: state.pokeAPI,
      filteredPokemonList: state.filteredPokemonList,
      pokemonActual: state.pokemonActual,
      positionActual: state.positionActual,
      corPokemon: state.corPokemon,
      searchQuery: state.searchQuery,
    ));
  }

  // Save the list of favorite Pokémon to shared preferences.
  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteNames = _favoritePokemon.map((pokemon) => pokemon.name).toList();
    await prefs.setStringList('favoritePokemons', favoriteNames);
  }

  // Load the list of favorite Pokémon from shared preferences.
  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteNames = prefs.getStringList('favoritePokemons') ?? [];
    _favoritePokemon = _allPokemon.where((pokemon) => favoriteNames.contains(pokemon.name)).toList();
  }

  // Return the selected filter.
  String get selectedFilter => _selectedFilter;
}
