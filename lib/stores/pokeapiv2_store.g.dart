// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokeapiv2_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokeApiV2Store _$PokeApiV2StoreFromJson(Map<String, dynamic> json) =>
    PokeApiV2Store()
      ..pokeApiV2 = json['pokeApiV2'] == null
          ? null
          : PokeApiV2.fromJson(json['pokeApiV2'] as Map<String, dynamic>)
      ..specie = json['specie'] == null
          ? null
          : Specie.fromJson(json['specie'] as Map<String, dynamic>);

Map<String, dynamic> _$PokeApiV2StoreToJson(PokeApiV2Store instance) =>
    <String, dynamic>{
      'pokeApiV2': instance.pokeApiV2,
      'specie': instance.specie,
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PokeApiV2Store on _PokeApiV2StoreBase, Store {
  late final _$pokeApiV2Atom =
      Atom(name: '_PokeApiV2StoreBase.pokeApiV2', context: context);

  @override
  PokeApiV2? get pokeApiV2 {
    _$pokeApiV2Atom.reportRead();
    return super.pokeApiV2;
  }

  @override
  set pokeApiV2(PokeApiV2? value) {
    _$pokeApiV2Atom.reportWrite(value, super.pokeApiV2, () {
      super.pokeApiV2 = value;
    });
  }

  late final _$specieAtom =
      Atom(name: '_PokeApiV2StoreBase.specie', context: context);

  @override
  Specie? get specie {
    _$specieAtom.reportRead();
    return super.specie;
  }

  @override
  set specie(Specie? value) {
    _$specieAtom.reportWrite(value, super.specie, () {
      super.specie = value;
    });
  }

  late final _$getInfoPokemonAsyncAction =
      AsyncAction('_PokeApiV2StoreBase.getInfoPokemon', context: context);

  @override
  Future<void> getInfoPokemon(String name) {
    return _$getInfoPokemonAsyncAction.run(() => super.getInfoPokemon(name));
  }

  late final _$getInfoSpecieAsyncAction =
      AsyncAction('_PokeApiV2StoreBase.getInfoSpecie', context: context);

  @override
  Future<void> getInfoSpecie(String name) {
    return _$getInfoSpecieAsyncAction.run(() => super.getInfoSpecie(name));
  }

  @override
  String toString() {
    return '''
pokeApiV2: ${pokeApiV2},
specie: ${specie}
    ''';
  }
}
