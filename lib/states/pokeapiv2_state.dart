import 'package:poke_star/models/specie.dart';

import '../models/pokeapiv2.dart';

abstract class PokeApiV2State {}

class PokeApiV2Initial extends PokeApiV2State {}

class PokeApiV2Loading extends PokeApiV2State {}

class PokeApiV2Loaded extends PokeApiV2State {
  final PokeApiV2 pokeApiV2;
  final Specie specie;

  PokeApiV2Loaded({required this.pokeApiV2, required this.specie});
}

class PokeApiV2Error extends PokeApiV2State {
  final String message;

  PokeApiV2Error({required this.message});
}