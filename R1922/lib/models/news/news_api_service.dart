import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import '/models/news/news_article.dart';
import 'package:html/dom.dart' as dom;
import 'package:shared_preferences/shared_preferences.dart';

class NewsApiService {
  final String cacheBoxName = 'news_cache';
  final String lastFetchTimeKey = 'lastFetchTime_news';
  final String newsCacheKey = 'newsList';
  final Dio _dio = Dio();

  Future<List<NewsArticle>> getWebsiteData() async {
    const url = 'http://kbvolna.com/news/';
// Получаем время последнего запроса из Shared Preferences
    final prefs = await SharedPreferences.getInstance();
    final lastFetchTime = prefs.getInt(lastFetchTimeKey);

    // Проверяем, прошло ли 60 минут с последнего запроса
    if (lastFetchTime != null &&
        DateTime.now().millisecondsSinceEpoch <
            lastFetchTime + 60 * 60 * 1000) {
      // Загружаем данные из кэша
      print('Загрузка данных из кэша');
      return await _loadFromCache();
    } else {
      print('Загрузка данных с сервера');
    }

    try {
      final response = await _dio.get(url);

      // Проверка статуса ответа
      if (response.statusCode == 200) {
        dom.Document html = dom.Document.html(response.data);

        final titles = html
            .querySelectorAll('div.news_title>a')
            .map((element) => element.innerHtml.trim())
            .toList();

        final dates = html
            .querySelectorAll('div.date')
            .map((element) => element.innerHtml.trim())
            .toList();

        final urlButton = html
            .querySelectorAll('div.news_item_content > div.txt > a')
            .map((element) => 'http://kbvolna.com${element.attributes['href']}')
            .toList();

        final urlImages = html
            .querySelectorAll('div.news_item_content > div.imgs > img')
            .map((element) => 'http://kbvolna.com/${element.attributes['src']}')
            .toList();

        // Создаем список новостей
        List<NewsArticle> newsArticles = List.generate(
            titles.length,
            (index) => NewsArticle(
                title: titles[index],
                dateNews: _formatDate(dates[index]),
                urlButton: urlButton[index],
                urlImage: urlImages[index]));

        // Сохраняем данные в кэш
        await _saveToCache(newsArticles);

        // Сохраняем текущее время как последнюю дату запроса
        prefs
            .setInt(lastFetchTimeKey, DateTime.now().millisecondsSinceEpoch)
            .toString();

        return newsArticles;
      } else {
        print('Ошибка при загрузке данных: ${response.statusCode}');
        // Обработка ошибки
        throw Exception(
            'Не удалось загрузить данные, статус: ${response.statusCode}');
      }
    } catch (e) {
      print('Ошибка сети: $e');
      // Попробуем загрузить данные из кэша, если произошла ошибка
      return await _loadFromCache();
    }
  }

  String _formatDate(String dateString) {
    // Разделяем строку по пробелу для получения даты и времени
    final parts = dateString.split(' ');
    if (parts.length < 2)
      return dateString; // Если не удается разбить строку, вернуть оригинал

    // Разделяем дату и время
    final datePart = parts[0]; // Число.месяц.год
    final timePart = parts[1].split(':').sublist(0, 2).join(':'); // Часы:Минуты

    // Возвращаем отформатированную строку в нужном вам виде
    return '$datePart $timePart';
  }

  // Метод для сохранения данных в кэш
  Future<void> _saveToCache(List<NewsArticle> news) async {
    var cacheBox = await Hive.openBox(cacheBoxName);
    cacheBox.put(newsCacheKey, news.map((news) => news.toJson()).toList());
  }

  // Метод для загрузки данных из кэша
  Future<List<NewsArticle>> _loadFromCache() async {
    var cacheBox = await Hive.openBox(cacheBoxName);
    List<dynamic>? cachedData = cacheBox.get(newsCacheKey);
    return cachedData != null
        ? cachedData
            .map((item) =>
                NewsArticle.fromJson(Map<dynamic, dynamic>.from(item)))
            .toList()
        : [];
  }
}
