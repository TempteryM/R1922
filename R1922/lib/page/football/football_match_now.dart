import 'dart:async';
import 'package:com.gds.radio1922/models/football/match_past/football_api_service_past.dart';
import 'package:com.gds.radio1922/widgets/match/match_now.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yandex_mobileads/mobile_ads.dart';
import '../../models/football/match_future/football_match_article.dart';
import '../../widgets/background.dart';

class FootballMatchNow extends StatefulWidget {
  @override
  _FootballMatchNowState createState() => _FootballMatchNowState();
}

class _FootballMatchNowState extends State<FootballMatchNow>
    with SingleTickerProviderStateMixin {
  final FootballApiServicePast _apiService = FootballApiServicePast();
  late Future<List<FootballMatchResponse>> _gamesFuture;
  late TabController _tabController;
  late ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();

    List<String> seasons = ["2024", "2025"];
    String team = "558";
    _gamesFuture = _apiService.fetchGamesForMultipleSeasons(seasons, team);
    _tabController = TabController(length: 2, vsync: this);
    _scrollViewController = ScrollController();
    MobileAds.initialize();
    someAsyncOperation(); // Вызов асинхронной операции
  }

  @override
  void setState(VoidCallback fn) {
    if (!mounted) return; // Проверка, что элемент еще в дереве
    super.setState(fn);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose(); // Освобождаем ScrollController
    super.dispose();
  }

  void someAsyncOperation() async {
    await Future.delayed(Duration(seconds: 1)); // Пример асинхронной операции

    // Проверяем, что виджет все еще в дереве
    if (mounted) {
      setState(() {
        // Обновление состояния, если необходимо
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Инициализация ScreenUtil здесь
    ScreenUtil.init(context, designSize: const Size(360, 690));
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackgroundApp(
      child: FutureBuilder<List<FootballMatchResponse>>(
        future: _gamesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: EdgeInsets.all(18.0),
              child: const Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasError) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                  child: const Text(
                      'Ошибка загрузки данных. Попробуйте еще раз.')),
            );
          }
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final matchs = snapshot.data!;

            return buildMatchNow(matchs);
          } else {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                  child: const Text(
                      'Нет данных для отображения. Попробуйте еще раз.')),
            );
          }
        },
      ),
    );
  }

  Widget buildMatchNow(List<FootballMatchResponse> matchs) {
    final match = matchs[0];
    return MatchNow(
      teamHome: match.teams!.home!.name!,
      teamAway: match.teams!.away!.name!,
      homeLogo: match.teams!.home!.logo!,
      awayLogo: match.teams!.away!.logo!,
      matchDate: match.fixture!.day!,
      matchDateTime: match.fixture!.time!,
      league: match.league!.name!,
      homeScore: match.goals!.home!,
      awayScore: match.goals!.away!,
      matchStatus: match.fixture!.status!.short.toString(),
      venue: 'БЛИЖАЙЩИЙ МАТЧ',
    );
  }
}
