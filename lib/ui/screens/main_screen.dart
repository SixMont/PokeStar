import 'package:flutter/material.dart';

import '../content/favorite_screen_content.dart';
import '../content/home_screen_content.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                _pageController.animateToPage(
                  0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
                setState(() {
                  _currentIndex = 0;
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: _currentIndex == 0 ? 120 : 0,
                    height: _currentIndex == 0 ? 40 : 0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      fontFamily: 'Google',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _currentIndex == 0 ? Colors.red : Colors.white,
                    ),
                    child: const Text('Pokédex'),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                _pageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
                setState(() {
                  _currentIndex = 1;
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: _currentIndex == 1 ? 120 : 0,
                    height: _currentIndex == 1 ? 40 : 0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      fontFamily: 'Google',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _currentIndex == 1 ? Colors.red : Colors.white,
                    ),
                    child: const Text('Pokéstar'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const [
          HomeScreenContent(), // Contenu du Pokédex
          FavoriteScreenContent(), // Contenu de Pokéstar
        ],
      ),
    );
  }
}


