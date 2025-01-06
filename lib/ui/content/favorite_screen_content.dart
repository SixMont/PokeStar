import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../consts/consts_app.dart';
import '../../models/pokeapi.dart';
import '../../states/pokeapi_cubit.dart';
import '../../states/pokeapi_state.dart';

class FavoriteScreenContent extends StatelessWidget {
  const FavoriteScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final pokeApiCubit = context.read<PokeApiCubit>();

    return BlocBuilder<PokeApiCubit, PokeApiState>(
      builder: (context, state) {
        if (state is PokeApiInitial) {
          pokeApiCubit.fetchPokemonList();
          return const Center(child: CircularProgressIndicator());
        } else if (state is PokeApiLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PokeApiLoaded) {
          final favoriteList = pokeApiCubit.favoritePokemonList;

          if (favoriteList.isEmpty) {
            return const Center(
              child: Text(
                'No favorite Pokémon found!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: pokeApiCubit.selectedFavorite,
                  onChanged: (String? newValue) {
                    pokeApiCubit.setSelectedFavorite(newValue);
                  },
                  items: favoriteList
                      .map<DropdownMenuItem<String>>(
                        (Pokemon pokemon) => DropdownMenuItem<String>(
                      value: pokemon.name,
                      child: Text(pokemon.name),
                    ),
                  )
                      .toList(),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: favoriteList.length,
                  itemBuilder: (context, index) {
                    final pokemon = favoriteList[index];
                    return GestureDetector(
                      onTap: () {
                        pokeApiCubit.setPokemonActual(index: index);
                        Navigator.pushNamed(context, '/detail');
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: ConstsApp.getColorType(
                              type: pokemon.type[0],
                            ),
                            backgroundImage: NetworkImage(
                              pokeApiCubit.getImage(
                                numero: pokemon.num,
                              ) as String,
                            ),
                          ),
                          title: Text(
                            pokemon.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            'ID: ${pokemon.num}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.star, color: Colors.red),
                            onPressed: () {
                              pokeApiCubit.toggleFavorite(pokemon);
                            },
                          ),
                        ),
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
    );
  }
}
