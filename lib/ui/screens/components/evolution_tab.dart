import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_star/states/pokeapi_cubit.dart';
import 'package:poke_star/states/pokeapi_state.dart';
import 'package:poke_star/models/pokeapi.dart';

class EvolutionTab extends StatelessWidget {
  final Pokemon pokemon;

  const EvolutionTab({super.key, required this.pokemon});

  Widget resizePokemon(Widget widget) {
    return SizedBox(height: 80, width: 80, child: widget);
  }

  List<Widget> getEvolution(Pokemon? pokemon, PokeApiCubit pokeApiCubit) {
    List<Widget> list = [];
    if (pokemon!.prevEvolution.isNotEmpty) {
      for (var f in pokemon.prevEvolution) {
        list.add(
          Column(
            children: [
              resizePokemon(pokeApiCubit.getImage(numero: f.num)),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Text(
                  f.name,
                  style: const TextStyle(
                    fontSize: 14,
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
        list.add(const Icon(Icons.arrow_forward, size: 24));
      }
    }
    list.add(
      Column(
        children: [
          resizePokemon(pokeApiCubit.getImage(numero: pokemon.num)),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(
              pokemon.name,
              style: const TextStyle(
                fontSize: 14,
                letterSpacing: 2.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );

    if (pokemon.nextEvolution.isNotEmpty) {
      list.add(const Icon(Icons.arrow_forward, size: 24));
      for (var f in pokemon.nextEvolution) {
        list.add(
          Column(
            children: [
              resizePokemon(pokeApiCubit.getImage(numero: f.num)),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Text(
                  f.name,
                  style: const TextStyle(
                    fontSize: 14,
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
        if (pokemon.nextEvolution.last.name != f.name) {
          list.add(const Icon(Icons.arrow_forward, size: 24));
        }
      }
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokeApiCubit, PokeApiState>(
      builder: (context, state) {
        if (state is PokeApiLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PokeApiLoaded) {
          List<Widget> evolutionWidgets =
          getEvolution(pokemon, context.read<PokeApiCubit>());

          return LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: const EdgeInsets.all(40.0),
                child: Center(
                  child: SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: evolutionWidgets,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else if (state is PokeApiError) {
          return Center(
              child: Text(state.message,
                  style: const TextStyle(fontSize: 18, color: Colors.red)));
        } else {
          return const Center(child: Text('Unknown state'));
        }
      },
    );
  }
}
