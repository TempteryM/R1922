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
    // Инициализация iTunes Artwork Parser
    _radioPlayer.itunesArtworkParser(true);

    // Установка канала
    _radioPlayer
        .setChannel(
      title: appNameScreen,
      url: linkStream,
      imagePath: 'assets/images/logo.png',
    )
        .then((_) {
      if (autoplay) play();
      notifyListeners();
    });

    // Подписка на поток метаданных
    _radioPlayer.metadataStream.listen((value) async {
      metadata = value;

      if (albumCover) {
        artwork = await _radioPlayer.getArtworkImage();
      }

      notifyListeners();
    });

    // Подписка на поток состояния воспроизведения
    _radioPlayer.stateStream.listen((state) {
      if (isPlaying != state) {
        isPlaying = state;
        isPlaying ? _onPlay() : _onPause();
      }
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
    // Здесь можно оставить только вызов notifyListeners()
    // без вызова reset(), если это не требуется.
  }

  void _reset() {
    artwork = Image.asset('assets/images/logo.png');

    // Остановка сервиса метаданных и сброс канала
    _metadataService?.stop();

    // Сброс метаданных
    metadata = [appNameScreen, appDescription];

    // Установка канала с новыми значениями
    _radioPlayer.setChannel(
      title: appDescription,
      url: linkStream,
      imagePath: 'assets/images/logo.png',
    );

    notifyListeners(); // Не забудьте уведомить слушателей о изменениях.
  }
}
