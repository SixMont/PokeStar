import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:poke_star/stores/pokeapi_store.dart';
import 'package:poke_star/ui/screens/home_screen.dart';
import 'package:poke_star/ui/screens/details_screen.dart';
import 'package:poke_star/ui/screens/favorites_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PokeApiStore>(create: (_) => PokeApiStore()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PokeStar',
        routes: {
          '/home': (context) => const HomeScreen(),
          '/detail': (context) => const DetailScreen(),
          '/favorite': (context) => const FavoritesScreen(),
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
