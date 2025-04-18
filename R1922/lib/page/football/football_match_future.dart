import 'dart:async';
import 'package:com.gds.radio1922/models/football/match_future/football_api_service.dart';
import 'package:com.gds.radio1922/widgets/match/match_future.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yandex_mobileads/mobile_ads.dart';
import '../../models/football/match_future/football_match_article.dart';
import '../../widgets/background.dart';

class FootballMatchFuture extends StatefulWidget {
  @override
  _FootballMatchFutureState createState() => _FootballMatchFutureState();
}

class _FootballMatchFutureState extends State<FootballMatchFuture>
    with SingleTickerProviderStateMixin {
  final FootballApiService _apiService = FootballApiService();
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

            return buildMatchCard(matchs);
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

  Widget buildMatchCard(List<FootballMatchResponse> matchs) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 6.h),
      itemCount: matchs.length - 1,
      itemBuilder: (context, index) {
        if ((index + 1) % 4 == 0) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 0.h),
            // child: AdBanner(),
          );
        } else {
          final match = matchs[index + 1];
          return MatchDate(
            teamHome: match.teams!.home!.name!,
            teamAway: match.teams!.away!.name!,
            homeLogo: match.teams!.home!.logo!,
            awayLogo: match.teams!.away!.logo!,
            matchDate: match.fixture!.day!,
            matchDateTime: match.fixture!.time!,
            league: match.league!.name!,
          );
        }
      },
    );
  }
}
