import 'package:hive/hive.dart';
import '/models/about/user_about.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserApiService {
  final String cacheBoxName = 'user_cache';
  final String lastFetchTimeKey = 'lastFetchTime_user';
  final userCacheKey = 'userList';

  Future<List<User>> getUsers() async {
    const url = 'https://kbvolna.com/Users.json';

    // Получаем время последнего запроса из Shared Preferences
    final prefs = await SharedPreferences.getInstance();
    final lastFetchTime = prefs.getInt(lastFetchTimeKey);

    // Проверяем, прошло ли 60 минут с последнего запроса
    if (lastFetchTime != null &&
        DateTime.now().millisecondsSinceEpoch <
            lastFetchTime + 24 * 60 * 60 * 1000) {
      // Загружаем данные из кэша
      print('Загрузка данных из кэша');
      return await _loadFromCache();
    } else {
      print('Загрузка данных с сервера');

      try {
        final response = await http.get(Uri.parse(url));

        // Проверка статуса ответа
        if (response.statusCode == 200) {
          // Декодируем данные, убедившись, что они соответствуют ожидаемому типу
          final body = json.decode(utf8.decode(response.bodyBytes));

          // Приводим body к List<dynamic> и затем к List<User>
          if (body is List) {
            List<User> users = body
                .map<User>(
                    (json) => User.fromJson(json as Map<String, dynamic>))
                .toList();

            // Сохраняем данные в кэш
            await _saveToCache(users);

            // Сохраняем текущее время как последнюю дату запроса
            prefs.setInt(
                lastFetchTimeKey, DateTime.now().millisecondsSinceEpoch);

            return users;
          } else {
            throw Exception('Полученные данные не являются списком');
          }
        } else {
          // Обработка ошибки
          throw Exception(
              'Не удалось загрузить пользователей, статус: ${response.statusCode}');
        }
      } catch (e) {
        // Обработка ошибок сети или парсинга
        throw Exception('Ошибка сети: $e');
      }
    }
  }

  // Метод для сохранения данных в кэш
  Future<void> _saveToCache(List<User> user) async {
    var cacheBox = await Hive.openBox(cacheBoxName);
    cacheBox.put(userCacheKey, user.map((user) => user.toJson()).toList());
  }

  // Метод для загрузки данных из кэша
  Future<List<User>> _loadFromCache() async {
    var cacheBox = await Hive.openBox(cacheBoxName);
    List<dynamic>? cachedData = cacheBox.get(userCacheKey);
    return cachedData != null
        ? cachedData
            .map((item) => User.fromJson(Map<String, dynamic>.from(item)))
            .toList()
        : [];
  }
}
