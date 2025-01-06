import 'package:bloc/bloc.dart';
import '../models/specie.dart';
import '../repository/pokerepositoryv2.dart';
import 'pokeapiv2_state.dart';

class PokeApiV2Cubit extends Cubit<PokeApiV2State> {
  final PokemonRepositoryV2 repository;
  Specie? _specie;

  PokeApiV2Cubit(this.repository) : super(PokeApiV2Initial());

  Specie? get specie => _specie;

  Future<void> getInfoSpecie(String name) async {
    try {
      emit(PokeApiV2Loading());
      final pokeApiV2 = await repository.fetchPokemonV2(name);
      final specie = await repository.fetchPokemonSpecie(name);
      emit(PokeApiV2Loaded(pokeApiV2: pokeApiV2, specie: specie));
    } catch (e) {
      emit(PokeApiV2Error(message: e.toString()));
    }
  }
}