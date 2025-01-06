import 'package:flutter/material.dart';
import 'package:poke_star/consts/consts_app.dart';
import 'package:provider/provider.dart';

import '../../states/pokeapi_cubit.dart';
import '../../states/pokeapiv2_cubit.dart';
import 'components/about_tab.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pokeApiCubit = context.read<PokeApiCubit>();
    final pokeApiCubitV2 = context.read<PokeApiV2Cubit>();
    final pokemon = pokeApiCubit.pokemonActual!;
    Color? corPokemon = ConstsApp.getColorType(type: pokemon.type[0]);
    int currentIndex = pokeApiCubit.positionActual!;
    int totalPokemon = pokeApiCubit.totalPokemon;

    void navigateToPokemon(int index) {
      pokeApiCubit.setPokemonActual(index: index);
      final newPokemon = pokeApiCubit.pokemonActual!;
      pokeApiCubitV2.getInfoSpecie(newPokemon.name);
      Navigator.pushReplacementNamed(
        context,
        '/detail',
      );
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
                child: const Column(
                  children: <Widget>[
                    SizedBox(height: 100, width: double.infinity),
                    Expanded(
                      child: Column(
                        children: [
                          TabBar(
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
                            indicatorColor: Colors.black,
                            labelStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.5,
                              fontFamily: 'Google',
                            ),
                            tabs: [
                              Tab(text: "About"),
                              Tab(text: "Evolution"),
                              Tab(text: "Status"),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                AboutTab(),
                                Center(
                                  child: Text(
                                    "Evolution content here",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        letterSpacing: 2.5),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "Status content here",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        letterSpacing: 2.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
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
                      child: Consumer<PokeApiCubit>(
                        builder: (context, pokeApiCubit, child) {
                          return pokeApiCubit.getImage(numero: pokemon.num);
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
            if (currentIndex < totalPokemon - 1)
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
                        if (currentIndex < totalPokemon - 1) {
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
      ),
    );
  }
}
