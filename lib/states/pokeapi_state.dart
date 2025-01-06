import '../models/pokeapi.dart';

abstract class PokeApiState {
  get pokeAPI => null;

  get filteredPokemonList => null;

  get pokemonAtual => null;

  get posicaoAtual => null;

  get corPokemon => null;

  get searchQuery => null;
}

class PokeApiInitial extends PokeApiState {}

class PokeApiLoading extends PokeApiState {}

class PokeApiLoaded extends PokeApiState {
  @override
  final PokeAPI pokeAPI;
  @override
  final List<Pokemon> filteredPokemonList;
  @override
  final Pokemon? pokemonAtual;
  @override
  final int? posicaoAtual;
  @override
  final dynamic corPokemon;
  @override
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
