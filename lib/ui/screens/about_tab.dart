import 'package:flutter/material.dart';
import '../../models/specie.dart';
import '../../stores/pokeapiv2_store.dart';
import 'package:provider/provider.dart';

class AboutTab extends StatelessWidget {
  const AboutTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PokeApiV2Store>(
      builder: (context, pokeApiV2Store, child) {
        Specie? specie = pokeApiV2Store.specie;
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
                  letterSpacing: 2.5
                ),
              ),
              const SizedBox(height: 10),
              specie == null
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : Text(
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
      },
    );
  }
}
