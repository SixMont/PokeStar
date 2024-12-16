import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:poke_star/stores/pokeapi_store.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Poké List'),
        centerTitle: true,
      ),
      body: Consumer<PokeApiStore>(
        builder: (context, pokeApiStore, child) {
          if (pokeApiStore.pokeAPI.pokemon.isEmpty) {
            pokeApiStore.fetchPokemonList();
          }

          return Observer(
            builder: (_) {
              if (pokeApiStore.pokeAPI.pokemon.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              return GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: pokeApiStore.pokeAPI.pokemon.length,
                itemBuilder: (context, index) {
                  final pokemon = pokeApiStore.getPokemon(index: index);

                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                          title: Text(pokemon.name),
                          content: Text('Numéro: ${pokemon.num}'),
                        );
                        },
                      );
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: pokeApiStore.getImage(numero: pokemon.num),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            pokemon.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            pokemon.num,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
