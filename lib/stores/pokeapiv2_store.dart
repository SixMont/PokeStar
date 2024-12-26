import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;

import '../consts/consts_api.dart';
import '../models/pokeapiv2.dart';
import '../models/specie.dart';

part 'pokeapiv2_store.g.dart';

@JsonSerializable()
class PokeApiV2Store = _PokeApiV2StoreBase with _$PokeApiV2Store;

abstract class _PokeApiV2StoreBase with Store {

  @observable
  PokeApiV2? pokeApiV2;

  @observable
  Specie? specie;

  @action
  Future<void> getInfoPokemon(String name) async {
    try {
      final response = await http.get(Uri.parse(ConstsAPI.pokeapiv2URL+name.toLowerCase()));
      var decodeJson = jsonDecode(response.body);
      pokeApiV2 = PokeApiV2.fromJson(decodeJson);
    } catch (error, stacktrace) {
      print("Error getting info pokemon : " + stacktrace.toString());
      return null;
    }
  }

  @action
  Future<void> getInfoSpecie(String name) async {
    try {
      final response = await http.get(Uri.parse(ConstsAPI.pokeapiv2SpeciesURL+name.toLowerCase()));
      var decodeJson = jsonDecode(response.body);
      var _specie = Specie.fromJson(decodeJson);
      specie = _specie;
    } catch (error, stacktrace) {
      print("Error getting info specie  : " + stacktrace.toString());
      return null;
    }
  }
}