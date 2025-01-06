import 'package:audioplayers/audioplayers.dart';

class MusicPlayer {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  // Méthode pour démarrer la musique
  static Future<void> playMusic() async {
    const musicUrl = 'music/generique_pokemon.mp3';
    try {
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      await _audioPlayer.play(AssetSource(musicUrl));
      await _audioPlayer.setVolume(1);
    } catch (e) {
      print('Erreur lors de la lecture de la musique: $e');
    }
  }

  // Méthode pour arrêter la musique
  static Future<void> stopMusic() async {
    await _audioPlayer.stop();
  }

  // Méthode pour mettre en pause
  static Future<void> pauseMusic() async {
    await _audioPlayer.pause();
  }

  // Méthode pour reprendre
  static Future<void> resumeMusic() async {
    await _audioPlayer.resume();
  }
}
