import '../models/pokeapi.dart';

abstract class PokeApiState {}

class PokeApiInitial extends PokeApiState {}

class PokeApiLoading extends PokeApiState {}

class PokeApiLoaded extends PokeApiState {
  final PokeAPI pokeAPI;
  final List<Pokemon> filteredPokemonList;
  final Pokemon? pokemonAtual;
  final int? posicaoAtual;
  final dynamic corPokemon;
  final String searchQuery;

  PokeApiLoaded({
    required this.pokeAPI,
    required this.filteredPokemonList,
    this.pokemonAtual,
    this.posicaoAtual,
    this.corPokemon,
    this.searchQuery = '',
  });

  PokeApiLoaded copyWith({
    List<Pokemon>? filteredPokemonList,
    Pokemon? pokemonAtual,
    int? posicaoAtual,
    dynamic corPokemon,
    String? searchQuery,
  }) {
    return PokeApiLoaded(
      pokeAPI: pokeAPI,
      filteredPokemonList: filteredPokemonList ?? this.filteredPokemonList,
      pokemonAtual: pokemonAtual ?? this.pokemonAtual,
      posicaoAtual: posicaoAtual ?? this.posicaoAtual,
      corPokemon: corPokemon ?? this.corPokemon,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class PokeApiError extends PokeApiState {
  final String message;

  PokeApiError({required this.message});
}
