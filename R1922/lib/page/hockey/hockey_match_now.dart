import 'dart:async';
import 'package:com.gds.radio1922/models/hockey/match_future/hockey_api_service.dart';
import 'package:com.gds.radio1922/models/hockey/match_future/hockey_match_article.dart';
import 'package:com.gds.radio1922/widgets/match/match_now.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yandex_mobileads/mobile_ads.dart';
import '../../widgets/background.dart';

class HockeyMatchNow extends StatefulWidget {
  @override
  _HockeyMatchNowState createState() => _HockeyMatchNowState();
}

class _HockeyMatchNowState extends State<HockeyMatchNow>
    with SingleTickerProviderStateMixin {
  final HockeyApiService _apiService = HockeyApiService();
  late Future<List<HockeyResponse>> _gamesFuture;
  late TabController _tabController;
  late ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();

    List<String> seasons = ["2021", "2022"];
    String team = "386";
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
      child: FutureBuilder<List<HockeyResponse>>(
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

            return buildmatchNow(matchs);
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

  Widget buildmatchNow(List<HockeyResponse> matchs) {
    final match = matchs[0];
    return MatchNow(
      teamHome: match.teams!.home!.name!,
      teamAway: match.teams!.away!.name!,
      homeLogo: match.teams!.home!.logo!,
      awayLogo: match.teams!.away!.logo!,
      matchDate: match.day!,
      matchDateTime: match.time!,
      league: match.league!.name!,
      homeScore: match.scores!.home.toString(),
      awayScore: match.scores!.away.toString(),
      matchStatus: match.status!.short.toString(),
      venue: 'БЛИЖАЙЩИЙ МАТЧ',
    );
  }
}
