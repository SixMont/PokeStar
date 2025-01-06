import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_star/states/pokeapiv2_cubit.dart';
import 'package:poke_star/states/pokeapiv2_state.dart';
import '../../../models/specie.dart';

class AboutTab extends StatelessWidget {
  const AboutTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokeApiV2Cubit, PokeApiV2State>(
      builder: (context, state) {
        if (state is PokeApiV2Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PokeApiV2Loaded) {
          Specie specie = state.specie;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.5,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  specie.flavorTextEntries
                      .where((flavor) => flavor.language.name == 'en')
                      .first
                      .flavorText
                      .replaceAll('\n', ' ')
                      .replaceAll('\f', ' '),
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 14,
                    letterSpacing: 2.5,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          );
        } else if (state is PokeApiV2Error) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.red,
              ),
            ),
          );
        } else {
          return const Center(
            child: Text('Unknown state'),
          );
        }
      },
    );
  }
}