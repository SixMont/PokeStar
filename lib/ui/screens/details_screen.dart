import 'package:flutter/material.dart';
import 'package:poke_star/consts/consts_app.dart';
import 'package:provider/provider.dart';

import '../../models/pokeapi.dart';
import '../../models/specie.dart';
import '../../stores/pokeapi_store.dart';
import '../../stores/pokeapiv2_store.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemon = ModalRoute.of(context)!.settings.arguments as Pokemon;
    Color? corPokemon = ConstsApp.getColorType(type: pokemon.type[0]);
    final pokeApiStore = Provider.of<PokeApiStore>(context);
    final pokeApiV2Store = Provider.of<PokeApiV2Store>(context, listen: false);
    int currentIndex = pokeApiStore.pokeAPI.pokemon.indexOf(pokemon);

    void navigateToPokemon(int index) {
      final newPokemon = pokeApiStore.getPokemon(index: index);
      pokeApiV2Store.getInfoPokemon(newPokemon.name);
      pokeApiV2Store.getInfoSpecie(newPokemon.name);
      Navigator.pushReplacementNamed(
        context,
        '/detail',
        arguments: newPokemon,
      );
    }

    return Scaffold(
      backgroundColor: corPokemon,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Colors.white, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.star_border,
                    color: Colors.white, size: 30),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [corPokemon!, Colors.white],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 100, width: double.infinity),
                  Expanded(
                    child: Consumer<PokeApiV2Store>(
                      builder: (context, pokeApiV2Store, child) {
                        Specie? specie = pokeApiV2Store.specie;
                        if (specie == null) {
                          pokeApiV2Store.getInfoSpecie(pokemon.name);
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return Text(specie.flavorTextEntries
                            .where((flavor) => flavor.language.name == 'en')
                            .first
                            .flavorText);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 3 - 180,
            left: MediaQuery.of(context).size.width / 2 - 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  ConstsApp.whitePokeball,
                  height: 200,
                  color: Colors.white.withAlpha((0.2 * 255).toInt()),
                ),
                Hero(
                  tag: pokemon.num,
                  child: SizedBox(
                    height: 200,
                    child: Consumer<PokeApiStore>(
                      builder: (context, pokeApiStore, child) {
                        return pokeApiStore.getImage(numero: pokemon.num);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (currentIndex > 0)
            Positioned(
              top: MediaQuery.of(context).size.height / 3 - 130,
              left: 16,
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha((0.2 * 255).toInt()),
                  borderRadius: BorderRadius.circular(45),
                ),
                child: Center(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.white, size: 22),
                    onPressed: () {
                      if (currentIndex > 0) {
                        navigateToPokemon(currentIndex - 1);
                      }
                    },
                  ),
                ),
              ),
            ),
          if (currentIndex < pokeApiStore.pokeAPI.pokemon.length - 1)
            Positioned(
              top: MediaQuery.of(context).size.height / 3 - 130,
              right: 16,
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha((0.2 * 255).toInt()),
                  borderRadius: BorderRadius.circular(45),
                ),
                child: Center(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios,
                        color: Colors.white, size: 22),
                    onPressed: () {
                      if (currentIndex <
                          pokeApiStore.pokeAPI.pokemon.length - 1) {
                        navigateToPokemon(currentIndex + 1);
                      }
                    },
                  ),
                ),
              ),
            ),
          Positioned(
            top: kToolbarHeight - 30,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      pokemon.name,
                      style: const TextStyle(
                        fontSize: 26,
                        letterSpacing: 2.5,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "#${pokemon.num}",
                      style: const TextStyle(
                        fontSize: 18,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: pokemon.type.map((type) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha((0.2 * 255).toInt()),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        type,
                        style: const TextStyle(
                          color: Colors.white,
                          letterSpacing: 2.0,
                          fontSize: 14,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
