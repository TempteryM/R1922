import 'package:flutter/material.dart';
import '/models/cache/Cache_service.dart';

class CacheClearButton extends StatelessWidget {
  final CacheService cacheService = CacheService();
  final List<String> boxNames; // Список имен боксов для очистки
  final List<String> lastFetchTimeKeys;
  // Список ключей для сброса таймера

  CacheClearButton({
    required this.boxNames,
    required this.lastFetchTimeKeys,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      onPressed: () async {
        await cacheService.clearCaches(
          boxNames,
          lastFetchTimeKeys,
        ); // Передаем список имен боксов и ключей
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Кэш успешно очищен')),
        );
      },
      child: Text('Очистить кэш'),
    );
  }
}
