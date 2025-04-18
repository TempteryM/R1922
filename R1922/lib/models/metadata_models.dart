import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:dart_common_utils/dart_common_utils.dart';
import '../constants/config.dart';

class MetadataService {
  MetadataService({
    required this.callback,
  });

  final Function(List<String>) callback;
  List<String>? _previousMetadata;
  Timer? _timer;

  void start() {
    _timer = Timer.periodic(const Duration(seconds: 1), _parser);
  }

  void stop() {
    _timer?.cancel();
  }

  Future<void> _parser(Timer t) async {
    var metadata = ['', '', '', ''];
    var title = '';

    try {
      final response = await http.get(Uri.parse('metadataUrl'));

      if (response.statusCode == 200) {
        final content = utf8.decode(response.bodyBytes);
        var map = json.decode(content) as Map<String, dynamic>;

        map = map['now_playing']?['song'] ?? map;

        title = map['titleTag'] ?? '';
        metadata[0] = map['artist'] ?? '';
        metadata[1] = map['title'] ?? '';
        metadata[2] = map['thumb'] ?? '';
        metadata[3] = map['album'] ?? '';

        // Удаление тегов из названия
        metadata[1] = metadata[1].replaceAll(RegExp(r'$$(\w+)][^]*?$$\1]'), '');
      } else {
        // Обработка ошибки HTTP
        print('Failed to load metadata: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching metadata: $e');
      // Альтернативный способ получения метаданных
      final content = await _fetchFallbackMetadata();
      title = content.betweenTag('titleTag');
      metadata[0] = content.betweenTag('artist');
      metadata[1] = content.betweenTag('title');
      metadata[2] = content.betweenTag('thumb');
      metadata[3] = content.betweenTag('album');
    }

    if (title.isNotEmpty) {
      final titleList = title.split(' - ');
      metadata[0] = titleList[0];
      metadata[1] = (titleList.length > 1) ? titleList[1] : '';
    }

    // Логика обработки пустых значений
    if (metadata[0].isEmpty && metadata[1].isEmpty) return;

    if (metadata[0].isEmpty) {
      metadata[0] = metadata[1];
      metadata[1] = '';
    }

    if (metadata[0].isEmpty) {
      metadata[1] = appNameScreen;
    }

    // Проверка на изменения метаданных
    if (!listEquals(metadata, _previousMetadata)) {
      _previousMetadata =
          List.from(metadata); // Создаем новый список для сравнения
      callback(metadata);
    }
  }

  Future<String> _fetchFallbackMetadata() async {
    // Реализуйте логику получения метаданных в случае ошибки
    return ''; // Верните пустую строку или другие данные по умолчанию
  }
}
