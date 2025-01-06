import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../consts/consts_app.dart';
import '../../models/pokeapi.dart';
import '../../states/pokeapi_cubit.dart';
import '../../states/pokeapi_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pokeApiCubit = context.read<PokeApiCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex'),
        backgroundColor: Colors.red,
      ),
      body: BlocBuilder<PokeApiCubit, PokeApiState>(
        builder: (context, state) {
          if (state is PokeApiInitial) {
            pokeApiCubit.fetchPokemonList();
            return const Center(child: CircularProgressIndicator());
          } else if (state is PokeApiLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PokeApiLoaded) {
            final filteredList = pokeApiCubit.filteredPokemonList;

            if (filteredList.isEmpty) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Pokémon...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onChanged: (value) => pokeApiCubit.setSearchQuery(value),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'No Pokémon found!',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Pokémon...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onChanged: (value) => pokeApiCubit.setSearchQuery(value),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final pokemon = filteredList[index];
                      return GestureDetector(
                        onTap: () async {
                          pokeApiCubit.setPokemonActual(index: index);
                          Navigator.pushNamed(
                            context,
                            '/detail',
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                            ConstsApp.getColorType(type: pokemon.type[0]),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(500, 0, 0, 0), // Even more opaque shadow
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: _buildPokemonCard(pokemon, pokeApiCubit),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is PokeApiError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            );
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}

Widget _buildPokemonCard(Pokemon pokemon, pokeApiStore) {
  return Stack(
    children: [
      Positioned(
        top: 8,
        right: 8,
        child: Text(
          pokemon.num,
          style: const TextStyle(
            fontSize: 14,
            letterSpacing: 2.0,
            color: Colors.white,
          ),
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Opacity(
                  opacity: 0.2,
                  child: Image.asset(
                    ConstsApp.whitePokeball,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: pokeApiStore.getImage(numero: pokemon.num),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            pokemon.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              letterSpacing: 2.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: pokemon.type.map((type) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(80, 255, 255, 255),
                ),
                child: Text(
                  type.trim(),
                  style: const TextStyle(
                    fontSize: 12,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ],
  );
}