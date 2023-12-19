import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:dart_common_utils/dart_common_utils.dart';
import '../constants/config.dart';

class MetadataService {
  MetadataService({
    required this.callback,
  });

  Function(List<String>) callback;
  List<String>? _previousMetadata;
  Timer? _timer;

  void start() => _timer = Timer.periodic(const Duration(seconds: 1), _parser);
  void stop() => _timer?.cancel();

  Future<void> _parser(Timer t) async {
    var metadata = ['', '', ''];
    var title = '';

    final response = await get(Uri.parse('metadataUrl'));
    final content = utf8.decode(response.bodyBytes);

    try {
      var map = json.decode(content) as Map<String, dynamic>;

      map = map['now_playing']?['song'] ?? map;

      title = map['titleTag'] ?? '';
      metadata[0] = map['artist'] ?? '';
      metadata[1] = map['title'] ?? '';
      metadata[2] = map['thumb'] ?? '';
      metadata[3] = map['album'] ?? '';

      metadata[1] = metadata[1].replaceAll(RegExp(r'\[(\w+)][^]*?\[\1]'), '');
    } catch (_) {
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

    if (metadata[0].isEmpty && metadata[1].isEmpty) {
      return;
    }

    if (metadata[0].isEmpty) {
      metadata[0] = metadata[1];
      metadata[1] = '';
    }

    if (metadata[0].isEmpty) {
      metadata[1] = appNameScreen;
    }

    if (!listEquals(metadata, _previousMetadata)) {
      _previousMetadata = metadata;
      callback(metadata);
    }
  }
}
