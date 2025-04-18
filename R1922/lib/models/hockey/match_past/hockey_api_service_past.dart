import 'dart:convert';
import 'package:com.gds.radio1922/models/hockey/match_future/hockey_match_article.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HockeyApiServicePast {
  final Dio _dio = Dio();
  final String cacheBoxName = 'hockey_cache_past';
  final String lastFetchTimeKey = 'lastFetchTimes_hockey_past';

  Future<List<HockeyResponse>> fetchGamesForMultipleSeasons(
      List<String> seasons, String team) async {
    List<HockeyResponse> allGames = [];

    for (String season in seasons) {
      try {
        final games = await fetchGames(season, team);
        allGames.addAll(games);
      } catch (e) {
        print('Ошибка получения игр для сезона $season: $e');
      }
      allGames.sort((a, b) {
        DateTime dateA = DateTime.parse(a.date!);
        DateTime dateB = DateTime.parse(b.date!);
        return -dateA.compareTo(dateB);
      });
    }

    return allGames;
  }

  Future<List<HockeyResponse>> fetchGames(String season, String team) async {
    final url = 'http://v1.hockey.api-sports.io/games?';
    final prefs = await SharedPreferences.getInstance();
    final lastFetchTimesString = prefs.getString(lastFetchTimeKey);
    final lastFetchTimes = lastFetchTimesString != null
        ? Map<String, int>.from(json.decode(lastFetchTimesString))
        : <String, int>{};

    // Проверяем, прошло ли 60 минут с последнего запроса
    if (lastFetchTimes.containsKey(season) &&
        DateTime.now().millisecondsSinceEpoch <
            lastFetchTimes[season]! + 60 * 60 * 1000) {
      print('Загрузка данных из кэша для сезона $season');
      return await _loadFromCache(season, team);
    } else {
      print('Загрузка данных с сервера для сезона $season');
    }

    final options = Options(
      headers: {
        'x-rapidapi-key': '',
        'x-rapidapi-host': 'v3.football.api-sports.io',
      },
    );

    try {
      final response = await _dio.get(
        url,
        queryParameters: {
          'season': season,
          'team': team,
        },
        options: options,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['response'];
        var res = data.map((gameJson) {
          if (gameJson is Map<String, dynamic>) {
            return HockeyResponse.fromJson(gameJson);
          } else {
            throw Exception('Неверный формат данных из API');
          }
        }).toList();

        // Оставляем только матчи, которые уже завершились
        DateTime now = DateTime.now();
        res.retainWhere((game) {
          DateTime gameDate = DateTime.parse(game.date!);
          return gameDate.isBefore(now);
        });

        // Сохраняем данные в кэш
        await _saveToCache(season, team, res);

        // Обновляем время последнего запроса для сезона
        lastFetchTimes[season] = DateTime.now().millisecondsSinceEpoch;
        prefs.setString(lastFetchTimeKey, json.encode(lastFetchTimes));

        return res;
      } else {
        throw Exception(
            'Ошибка: ${response.statusCode} - ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Ошибка: $e');
    }
  }

  Future<void> _saveToCache(
      String season, String team, List<HockeyResponse> matches) async {
    var cacheBox = await Hive.openBox(cacheBoxName);
    String cacheKey = '$season-$team';
    List<Map> matchData = matches.map((match) => match.toJson()).toList();

    print('Сохранение данных в кэш для $cacheKey: $matchData');
    await cacheBox.put(cacheKey, matchData);
  }

  Future<List<HockeyResponse>> _loadFromCache(
      String season, String team) async {
    var cacheBox = await Hive.openBox(cacheBoxName);
    String cacheKey = '$season-$team';

    List<dynamic>? cachedData = cacheBox.get(cacheKey) as List<dynamic>? ?? [];
    print('Данные из кэша для $cacheKey: $cachedData');

    List<HockeyResponse> matchList = [];
    for (var item in cachedData) {
      try {
        matchList.add(HockeyResponse.fromJson(item as Map<dynamic, dynamic>));
      } catch (e) {
        print('Ошибка преобразования элемента: $e. Элемент: $item');
      }
    }

    return matchList;
  }
}
