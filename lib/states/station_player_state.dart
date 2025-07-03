// import 'dart:ui';
import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class PlayerProvider extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;

  late String stationName = 'Default Station Name';
  late String stationImage = 'Default Image URL';

  bool get isPlaying => _isPlaying;
  AudioPlayer get player => _player;

  PlayerProvider() {
    _player.playerStateStream.listen((state) {
      final playing =
          state.playing && state.processingState == ProcessingState.ready;
      if (_isPlaying != playing) {
        _isPlaying = playing;
        notifyListeners();
      }
    });
  }

  Future<void> setStationName(String name) async {
    stationName = name;
    notifyListeners();
  }

  Future<void> setStationImage(String imageUrl) async {
    stationImage = imageUrl;
    notifyListeners();
  }

  Future<void> play() async {
    await _player.play();
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> stop() async {
    await _player.stop();
  }

  Future<void> setSource(String url) async {
    await _player.setAudioSource(AudioSource.uri(Uri.parse(url)));
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _player.stop();
    }
  }
}
