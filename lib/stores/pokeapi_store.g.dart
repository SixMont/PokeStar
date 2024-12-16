// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokeapi_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PokeApiStore on _PokeApiStoreBase, Store {
  Computed<PokeAPI>? _$pokeAPIComputed;

  @override
  PokeAPI get pokeAPI =>
      (_$pokeAPIComputed ??= Computed<PokeAPI>(() => super.pokeAPI,
              name: '_PokeApiStoreBase.pokeAPI'))
          .value;
  Computed<Pokemon>? _$pokemonActualComputed;

  @override
  Pokemon get pokemonActual =>
      (_$pokemonActualComputed ??= Computed<Pokemon>(() => super.pokemonActual,
              name: '_PokeApiStoreBase.pokemonActual'))
          .value;

  late final _$_pokeAPIAtom =
      Atom(name: '_PokeApiStoreBase._pokeAPI', context: context);

  @override
  PokeAPI get _pokeAPI {
    _$_pokeAPIAtom.reportRead();
    return super._pokeAPI;
  }

  bool __pokeAPIIsInitialized = false;

  @override
  set _pokeAPI(PokeAPI value) {
    _$_pokeAPIAtom
        .reportWrite(value, __pokeAPIIsInitialized ? super._pokeAPI : null, () {
      super._pokeAPI = value;
      __pokeAPIIsInitialized = true;
    });
  }

  late final _$_pokemonActualAtom =
      Atom(name: '_PokeApiStoreBase._pokemonActual', context: context);

  @override
  Pokemon get _pokemonActual {
    _$_pokemonActualAtom.reportRead();
    return super._pokemonActual;
  }

  bool __pokemonActualIsInitialized = false;

  @override
  set _pokemonActual(Pokemon value) {
    _$_pokemonActualAtom.reportWrite(
        value, __pokemonActualIsInitialized ? super._pokemonActual : null, () {
      super._pokemonActual = value;
      __pokemonActualIsInitialized = true;
    });
  }

  late final _$corPokemonAtom =
      Atom(name: '_PokeApiStoreBase.corPokemon', context: context);

  @override
  dynamic get corPokemon {
    _$corPokemonAtom.reportRead();
    return super.corPokemon;
  }

  @override
  set corPokemon(dynamic value) {
    _$corPokemonAtom.reportWrite(value, super.corPokemon, () {
      super.corPokemon = value;
    });
  }

  late final _$positionActualAtom =
      Atom(name: '_PokeApiStoreBase.positionActual', context: context);

  @override
  int get positionActual {
    _$positionActualAtom.reportRead();
    return super.positionActual;
  }

  bool _positionActualIsInitialized = false;

  @override
  set positionActual(int value) {
    _$positionActualAtom.reportWrite(
        value, _positionActualIsInitialized ? super.positionActual : null, () {
      super.positionActual = value;
      _positionActualIsInitialized = true;
    });
  }

  late final _$_PokeApiStoreBaseActionController =
      ActionController(name: '_PokeApiStoreBase', context: context);

  @override
  dynamic fetchPokemonList() {
    final _$actionInfo = _$_PokeApiStoreBaseActionController.startAction(
        name: '_PokeApiStoreBase.fetchPokemonList');
    try {
      return super.fetchPokemonList();
    } finally {
      _$_PokeApiStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPokemonAtual({required int index}) {
    final _$actionInfo = _$_PokeApiStoreBaseActionController.startAction(
        name: '_PokeApiStoreBase.setPokemonAtual');
    try {
      return super.setPokemonAtual(index: index);
    } finally {
      _$_PokeApiStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Widget getImage({required String numero}) {
    final _$actionInfo = _$_PokeApiStoreBaseActionController.startAction(
        name: '_PokeApiStoreBase.getImage');
    try {
      return super.getImage(numero: numero);
    } finally {
      _$_PokeApiStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
corPokemon: ${corPokemon},
positionActual: ${positionActual},
pokeAPI: ${pokeAPI},
pokemonActual: ${pokemonActual}
    ''';
  }
}
