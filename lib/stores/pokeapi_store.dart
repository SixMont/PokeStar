import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:poke_star/consts/consts_api.dart';
import 'package:poke_star/consts/consts_app.dart';
import 'package:poke_star/models/pokeapi.dart';
import 'package:http/http.dart' as http;
part 'pokeapi_store.g.dart';

class PokeApiStore = _PokeApiStoreBase with _$PokeApiStore;

abstract class _PokeApiStoreBase with Store {
  @observable
  late PokeAPI _pokeAPI = PokeAPI(pokemon: []);

  @observable
  late Pokemon _pokemonAtual;

  @observable
  dynamic corPokemon;

  @observable
  late int posicaoAtual;

  @computed
  PokeAPI get pokeAPI => _pokeAPI;

  @computed
  Pokemon get pokemonAtual => _pokemonAtual;

  @action
  fetchPokemonList() {
    loadPokeAPI().then((pokeList) {
      _pokeAPI = pokeList!;
    });
  }

  Pokemon getPokemon({required int index}) {
    return _pokeAPI.pokemon[index];
  }

  @action
  setPokemonAtual({required int index}) {
    _pokemonAtual = _pokeAPI.pokemon[index];
    corPokemon = ConstsApp.getColorType(type: _pokemonAtual.type[0]);
    posicaoAtual = index;
  }

  @action
  Widget getImage({required String numero}) {
    return CachedNetworkImage(
      placeholder: (context, url) => new Container(
        color: Colors.transparent,
      ),
      imageUrl:
          'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$numero.png',
    );
  }

  Future<PokeAPI?> loadPokeAPI() async {
    try {
      final response = await http.get(ConstsAPI.pokeapiURL as Uri);
      var decodeJson = jsonDecode(response.body);
      return PokeAPI.fromJson(decodeJson);
    } catch (error, stacktrace) {
      return null;
    }
  }
}
