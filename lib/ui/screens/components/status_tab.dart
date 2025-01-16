import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/pokeapi.dart';
import '../../../models/pokeapiv2.dart';
import '../../../states/pokeapiv2_cubit.dart';
import '../../../states/pokeapiv2_state.dart';

class StatusTab extends StatelessWidget {
  final Pokemon pokemon;

  const StatusTab({super.key, required this.pokemon});

  List<int> getStatusPokemon(PokeApiV2 pokeApiV2) {
    List<int> list = [1, 2, 3, 4, 5, 6, 7];
    int sum = 0;
    for (var f in pokeApiV2.stats) {
      sum += f.baseStat;
      switch (f.stat.name) {
        case 'speed':
          list[0] = f.baseStat;
          break;
        case 'special-defense':
          list[1] = f.baseStat;
          break;
        case 'special-attack':
          list[2] = f.baseStat;
          break;
        case 'defense':
          list[3] = f.baseStat;
          break;
        case 'attack':
          list[4] = f.baseStat;
          break;
        case 'hp':
          list[5] = f.baseStat;
          break;
      }
    }
    list[6] = sum;
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokeApiV2Cubit, PokeApiV2State>(
      builder: (context, state) {
        if (state is PokeApiV2Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PokeApiV2Loaded) {
          List<int> statusList = getStatusPokemon(state.pokeApiV2);

          return LayoutBuilder(
            builder: (context, constraints) {
              return Center(
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
                          children: <Widget>[
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Speed', style: TextStyle(fontSize: 16, color: Colors.grey)),
                                SizedBox(height: 10),
                                Text('Sp. Def', style: TextStyle(fontSize: 16, color: Colors.grey)),
                                SizedBox(height: 10),
                                Text('Sp. Atk', style: TextStyle(fontSize: 16, color: Colors.grey)),
                                SizedBox(height: 10),
                                Text('Defense', style: TextStyle(fontSize: 16, color: Colors.grey)),
                                SizedBox(height: 10),
                                Text('Attack', style: TextStyle(fontSize: 16, color: Colors.grey)),
                                SizedBox(height: 10),
                                Text('HP', style: TextStyle(fontSize: 16, color: Colors.grey)),
                                SizedBox(height: 10),
                                Text('Total', style: TextStyle(fontSize: 16, color: Colors.grey)),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Column(
                              children: statusList
                                  .map(
                                    (stat) => Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    stat.toString(),
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                                  .toList(),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              children: statusList
                                  .map(
                                    (stat) {
                                  final isTotal = stat == statusList.last;
                                  final maxStat = isTotal ? 600 : 160;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: StatusBar(widthFactor: stat / maxStat),
                                  );
                                },
                              )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is PokeApiV2Error) {
          return Center(
            child: Text(state.message, style: const TextStyle(fontSize: 18, color: Colors.red)),
          );
        } else {
          return const Center(child: Text('Unknown state'));
        }
      },
    );
  }
}

class StatusBar extends StatelessWidget {
  final double widthFactor;

  const StatusBar({super.key, required this.widthFactor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 19,
      child: Center(
        child: Container(
          height: 5,
          width: MediaQuery.of(context).size.width * .47,
          alignment: Alignment.centerLeft,
          decoration: const ShapeDecoration(
            shape: StadiumBorder(),
            color: Colors.grey,
          ),
          child: FractionallySizedBox(
            widthFactor: widthFactor,
            heightFactor: 1.0,
            child: Container(
              decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                color: widthFactor > 0.5 ? Colors.teal : Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
