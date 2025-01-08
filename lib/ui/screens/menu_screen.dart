import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_star/music/music_player.dart';
import 'package:poke_star/states/pokeapi_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';  // build don't work so I import the package

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late String _selectedImageType;
  double _currentVolume = 1.0;
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedImageType =
          prefs.getString('selectedImageType') ?? 'Original Image';
      _currentVolume = prefs.getDouble('currentVolume') ?? 1.0;
      _isPlaying = prefs.getBool('isPlaying') ?? true;
    });
    MusicPlayer.setVolume(_currentVolume);
    if (_isPlaying) {
      MusicPlayer.resumeMusic();
    } else {
      MusicPlayer.pauseMusic();
    }
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedImageType', _selectedImageType);
    await prefs.setDouble('currentVolume', _currentVolume);
    await prefs.setBool('isPlaying', _isPlaying);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: const Text('Menu', style: TextStyle(color: Colors.black)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: _selectedImageType,
              items: const [
                DropdownMenuItem(
                  value: 'Original Image',
                  child: Text('Original Image'),
                ),
                DropdownMenuItem(
                  value: 'Image Pokemon GO',
                  child: Text('Image Pokemon GO'),
                ),
              ],
              onChanged: (String? newValue) {
                if (newValue != null && newValue != _selectedImageType) {
                  setState(() {
                    _selectedImageType = newValue;
                  });
                  context.read<PokeApiCubit>().toggleImageUrl();
                  _savePreferences();
                }
              },
            ),
            const SizedBox(height: 10),
            const Divider(
              height: 2,
              thickness: 0.5,
              color: Colors.grey,
              indent: 20,
              endIndent: 20,
            ),
            const SizedBox(height: 10),
            Text('Volume: ${(_currentVolume * 100).toInt()}%'),
            Slider(
              value: _currentVolume,
              min: 0.0,
              max: 1.0,
              divisions: 100,
              label: (_currentVolume * 100).toInt().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentVolume = value;
                });
                MusicPlayer.setVolume(value);
                _savePreferences();
              },
              activeColor: Colors.grey,
              inactiveColor: Colors.grey[300],
              thumbColor: Colors.grey,
            ),
            const SizedBox(height: 10),
            const Divider(
              height: 1.5,
              thickness: 0.5,
              color: Colors.grey,
              indent: 20,
              endIndent: 20,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Music: '),
                IconButton(
                  icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: () {
                    setState(() {
                      if (_isPlaying) {
                        MusicPlayer.pauseMusic();
                      } else {
                        MusicPlayer.resumeMusic();
                      }
                      _isPlaying = !_isPlaying;
                    });
                    _savePreferences();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
