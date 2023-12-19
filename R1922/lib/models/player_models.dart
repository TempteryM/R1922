import 'package:flutter/material.dart';
import 'package:radio_player/radio_player.dart';
import '/constants/config.dart';
import '../models/metadata_models.dart';

class PlayerScreenModel with ChangeNotifier {
  final _radioPlayer = RadioPlayer();

  bool isPlaying = false;

  Image? artwork;

  List<String>? metadata;

  MetadataService? _metadataService;

  String get artist => metadata?[0] ?? appNameScreen;

  String get track => metadata?[1] ?? appDescription;

  PlayerScreenModel() {
    //Itunes Album

    if (true) {
      _radioPlayer.itunesArtworkParser(true);
    }

    _radioPlayer
        .setChannel(
            title: appNameScreen,
            url: linkStream,
            imagePath: 'assets/images/logo.png')
        .then((_) {
      if (autoplay) play();

      notifyListeners();
    });

    _radioPlayer.metadataStream.listen((value) async {
      metadata = value;

      if (albumCover) artwork = await _radioPlayer.getArtworkImage();

      notifyListeners();
    });

    _radioPlayer.stateStream.listen((state) {
      if (isPlaying == state) return;

      isPlaying = state;

      isPlaying ? _onPlay() : _onPause();
    });
  }

  void play() {
    isPlaying = true;

    _radioPlayer.play();

    _onPlay();
  }

  void pause() {
    isPlaying = false;

    _radioPlayer.pause();

    _onPause();

    _reset();
  }

  void _onPlay() {
    notifyListeners();

    _metadataService?.start();
  }

  void _onPause() {
    notifyListeners();

    _reset();
  }

  void _reset() {
    artwork = Image.asset('assets/images/logo.png');

    _metadataService?.stop();

    _radioPlayer.stop();

    _radioPlayer.setChannel(
        title: appDescription,
        url: linkStream,
        imagePath: 'assets/images/logo.png');

    metadata?[0] = appNameScreen;

    metadata?[1] = appDescription;
  }
}
