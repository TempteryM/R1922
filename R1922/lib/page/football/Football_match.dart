import 'dart:async';
import 'package:com.gds.radio1922/page/football/football_match_future.dart';
import 'package:com.gds.radio1922/page/football/football_match_now.dart';
import 'package:com.gds.radio1922/page/football/football_match_past.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yandex_mobileads/mobile_ads.dart';
import '../../widgets/background.dart';

class FootballMatchScreen extends StatefulWidget {
  @override
  _FootballMatchScreenState createState() => _FootballMatchScreenState();
}

class _FootballMatchScreenState extends State<FootballMatchScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();

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
      child: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: CustomBackgroundApp(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    // Уберите Expanded если возникают ошибки с ограничениями по высоте
                    FootballMatchNow(),
                  ],
                ),
              ),
            ),
            surfaceTintColor: Colors.red,
            expandedHeight: 160.w, // Убедитесь что ScreenUtil инициализирован
            elevation: 0,
            pinned: true,
            floating: true,
            bottom: TabBar(
              dividerHeight: 25.w,
              dividerColor: Colors.grey[300],
              indicatorColor: Colors.transparent,
              unselectedLabelColor: Colors.black,
              labelStyle: Theme.of(context).textTheme.titleMedium,
              controller: _tabController,
              tabs: [
                // Упростите структуру табов если возможно
                _textFuture(context),
                _textPast(context),
              ],
            ),
          )
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            FootballMatchFuture(),
            FootballMatchPast(),
          ],
        ),
      ),
    );
  }

  Widget _textFuture(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.event_outlined,
          size: 20.sp,
        ),
        SizedBox(
          width: 5.h,
        ),
        const Text(
          'ПРЕДСТОЯЩИЕ',
          textAlign: TextAlign.start,
        ),
      ],
    );
  }

  Widget _textPast(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.event_available_outlined,
          size: 20.sp,
        ),
        SizedBox(
          width: 5.h,
        ),
        const Text(
          'ПРОШЕДШИЕ',
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}
