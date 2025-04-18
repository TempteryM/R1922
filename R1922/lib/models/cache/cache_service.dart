import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';

class CacheService {
  // Метод для очистки кэша нескольких боксов
  Future<void> clearCaches(
      List<String> boxNames, List<String> lastFetchTimeKeys) async {
    final prefs = await SharedPreferences
        .getInstance(); // Получаем экземпляр SharedPreferences

    for (String boxName in boxNames) {
      var box = await Hive.openBox(boxName); // Открываем указанный бокс
      await box.clear(); // Очищаем все данные в боксе
      print('Кэш для $boxName очищен');
    }

    // Сброс времени последнего запроса для всех ключей
    for (String key in lastFetchTimeKeys) {
      // Сбрасываем значение для каждого ключа
      await prefs.remove(key); // Удаляем значение для ключа
      print('Сброшено время последнего запроса для $key');
    }
  }
}
