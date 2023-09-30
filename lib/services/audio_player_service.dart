import 'package:just_audio/just_audio.dart';

class AudioPlayerService {
  AudioPlayerService._();
  static AudioPlayerService instance = AudioPlayerService._();

  late final AudioPlayer player;

  Future<void> init() async {
    player = AudioPlayer();
  }
}
