import 'package:flutter/material.dart';
import 'package:poke_star/consts/consts_app.dart';
import 'package:poke_star/ui/screens/components/evolution_tab.dart';
import 'package:poke_star/ui/screens/components/status_tab.dart';
import 'package:provider/provider.dart';

import '../../models/pokeapi.dart';
import '../../states/pokeapi_cubit.dart';
import '../../states/pokeapiv2_cubit.dart';
import 'components/about_tab.dart';

class DetailScreen extends StatefulWidget {
  final List<Pokemon> pokemonList;
  final int initialIndex;

  const DetailScreen({super.key, required this.pokemonList, required this.initialIndex});

  @override
  DetailScreenState createState() => DetailScreenState();
}

class DetailScreenState extends State<DetailScreen> with SingleTickerProviderStateMixin {
  late ValueNotifier<bool> isFavorite;
  late AnimationController _controller;
  late Animation<double> _animation;
  late PageController _pageController;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    final pokeApiCubit = context.read<PokeApiCubit>();
    currentIndex = widget.initialIndex;

    isFavorite = ValueNotifier(pokeApiCubit.favoritePokemon.contains(widget.pokemonList[currentIndex]));

    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);

    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pokeApiCubit = context.read<PokeApiCubit>();
    Color? corPokemon = ConstsApp.getColorType(type: widget.pokemonList[currentIndex].type[0]);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: corPokemon,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 30),
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
                    pokeApiCubit.toggleFavorite(widget.pokemonList[currentIndex]);
                    isFavorite.value = !isFavorite.value;
                  },
                );
              },
            ),
          ],
        ),
        body: Stack(
          children: [
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
                        widget.pokemonList[currentIndex].name,
                        style: const TextStyle(
                          fontSize: 26,
                          letterSpacing: 2.5,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "#${widget.pokemonList[currentIndex].num}",
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
                    children: widget.pokemonList[currentIndex].type.map((type) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: widget.pokemonList.length,
                      onPageChanged: (newIndex) {
                        setState(() {
                          currentIndex = newIndex;
                          isFavorite.value = pokeApiCubit.favoritePokemon.contains(widget.pokemonList[currentIndex]);
                        });
                        context.read<PokeApiV2Cubit>().getInfoSpecie(widget.pokemonList[currentIndex].name);
                      },
                      itemBuilder: (context, index) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              top: 120,
                              child: RotationTransition(
                                turns: _animation,
                                child: Image.asset(
                                  ConstsApp.whitePokeball,
                                  height: 200,
                                  color: Colors.white.withAlpha((0.2 * 255).toInt()),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 120,
                              child: Hero(
                                tag: widget.pokemonList[index].num,
                                child: SizedBox(
                                  height: 200,
                                  child: Consumer<PokeApiCubit>(
                                    builder: (context, pokeApiCubit, child) {
                                      return pokeApiCubit.getImage(numero: widget.pokemonList[index].num);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          const TabBar(
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
                            indicatorColor: Colors.black,
                            labelStyle: TextStyle(
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
                                AboutTab(pokemon: widget.pokemonList[currentIndex]),
                                EvolutionTab(pokemon: widget.pokemonList[currentIndex]),
                                StatusTab(pokemon: widget.pokemonList[currentIndex]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
