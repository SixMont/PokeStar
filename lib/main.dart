import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_star/repository/pokerepository.dart';
import 'package:poke_star/repository/pokerepositoryv2.dart';
import 'package:poke_star/states/pokeapi_cubit.dart';
import 'package:poke_star/states/pokeapiv2_cubit.dart';
import 'package:poke_star/ui/screens/details_screen.dart';
import 'package:poke_star/ui/screens/main_screen.dart';

import 'consts/consts_api.dart';
import 'music/music_player.dart';

void main() {
  runApp(const MyApp());
  MusicPlayer.playMusic(); // Démarrez la musique de fond
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PokeApiCubit>(
          create: (_) => PokeApiCubit(PokemonRepository(apiUrl: ConstsAPI.pokeapiURL)),
        ),
        BlocProvider<PokeApiV2Cubit>(
          create: (_) => PokeApiV2Cubit(PokemonRepositoryV2(apiUrl1: ConstsAPI.pokeapiv2URL, apiUrl2: ConstsAPI.pokeapiv2SpeciesURL)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PokeStar',
        routes: {
          '/home': (context) => const MainScreen(),
          '/detail': (context) => const DetailScreen(),
        },
        initialRoute: '/home',
        theme: ThemeData(
          primarySwatch: Colors.red,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.red,
          ),
          useMaterial3: true,
          fontFamily: 'Google',
          brightness: Brightness.light,
        ),
      ),
    );
  }
}
