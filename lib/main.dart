import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_star/repository/pokerepository.dart';
import 'package:poke_star/states/pokeapi_cubit.dart';
import 'package:poke_star/ui/screens/details_screen.dart';
import 'package:poke_star/ui/screens/main_screen.dart';
import 'package:poke_star/ui/screens/menu_screen.dart';

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PokeStar',
        routes: {
          '/home': (context) => const MainScreen(),
          '/detail': (context) => const DetailScreen(),
          '/menu': (context) => const MenuScreen(),
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
