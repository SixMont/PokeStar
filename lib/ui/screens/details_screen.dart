import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_star/consts/consts_app.dart';
import 'package:poke_star/ui/screens/components/evolution_tab.dart';
import 'package:poke_star/ui/screens/components/status_tab.dart';
import 'package:provider/provider.dart';

import '../../states/pokeapi_cubit.dart';
import '../../states/pokeapiv2_cubit.dart';
import 'components/about_tab.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late ValueNotifier<bool> isFavorite;

  @override
  void initState() {
    super.initState();
    final pokeApiCubit = context.read<PokeApiCubit>();
    final pokemon = pokeApiCubit.pokemonActual!;
    isFavorite = ValueNotifier(pokeApiCubit.favoritePokemon.contains(pokemon));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final pokeApiCubit = context.read<PokeApiCubit>();
    final pokemon = pokeApiCubit.pokemonActual!;
    isFavorite.value = pokeApiCubit.favoritePokemon.contains(pokemon);
    print('isFavorite: ${isFavorite.value}');
    print('favoritePokemonList: ${pokeApiCubit.favoritePokemon}');
  }

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
            ValueListenableBuilder<bool>(
              valueListenable: isFavorite,
              builder: (context, value, child) {
                return IconButton(
                  icon: Icon(
                    value ? Icons.star : Icons.star_border,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    pokeApiCubit.toggleFavorite(pokemon);
                    isFavorite.value = !isFavorite.value;
                  },
                );
              },
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
                                EvolutionTab(),
                                StatusTab()
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
            GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.velocity.pixelsPerSecond.dx < 0 &&
                    currentIndex < totalPokemon - 1) {
                  // Swipe vers la gauche (afficher le Pokémon suivant)
                  navigateToPokemon(currentIndex + 1);
                } else if (details.velocity.pixelsPerSecond.dx > 0 &&
                    currentIndex > 0) {
                  // Swipe vers la droite (afficher le Pokémon précédent)
                  navigateToPokemon(currentIndex - 1);
                }
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
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
                      child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                    ),
                  if (currentIndex < totalPokemon - 1)
                    Positioned(
                      top: MediaQuery.of(context).size.height / 3 - 130,
                      right: 16,
                      child: Icon(Icons.arrow_forward_ios, color: Colors.white),
                    ),
                ],
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