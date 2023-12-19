import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:radio1922/widgets/Football_match.dart';
import 'package:radio1922/widgets/hockey_match.dart';
import '../constants/language.dart';

class MatchViewScreen extends StatefulWidget {
  const MatchViewScreen({Key? key}) : super(key: key);
  static const routeName = '/match';

  @override
  State<MatchViewScreen> createState() => MatchViewScreenState();
}

class MatchViewScreenState extends State<MatchViewScreen> {
  set launched(Future<void> launched) {}
  late final viewModel = Provider.of<MatchViewScreen>(context, listen: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: _textTitleBar(context),
          centerTitle: true,
          titleTextStyle: Theme.of(context).textTheme.titleLarge,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          elevation: 0,
          flexibleSpace: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black, spreadRadius: 0.9.h, blurRadius: 5.h),
              ],
              color: Theme.of(context).colorScheme.primary,
              gradient: LinearGradient(
                tileMode: TileMode.clamp,
                colors: [
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.onBackground,
                  Theme.of(context).colorScheme.onBackground,
                  Theme.of(context).colorScheme.surface,
                ],
                stops: [0.3.h, 0.9.h, 3.h, 3.h],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          bottom: TabBar(
            dividerHeight: 25.w,
            indicatorPadding: EdgeInsets.zero,
            dividerColor: Colors.grey[300],
            indicatorColor: Colors.transparent,
            unselectedLabelColor: Colors.black,
            labelStyle: Theme.of(context).textTheme.titleMedium,
            tabs: [
              _textFootball(context),
              _textHockey(context),
            ],
          ),
        ),
        body: const SafeArea(
          child: TabBarView(
            children: [
              FootballMatch(),
              HockeyMatch(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _textTitleBar(context) {
  return Text(Language.matchData,
      style: Theme.of(context).textTheme.titleLarge);
}

Widget _textFootball(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        Icons.sports_soccer,
        size: 20.sp,
      ),
      SizedBox(
        width: 5.h,
      ),
      const Text(
        'ФУТБОЛ',
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Widget _textHockey(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        Icons.sports_hockey,
        size: 20.sp,
      ),
      SizedBox(
        width: 5.h,
      ),
      const Text(
        'ХОККЕЙ',
        textAlign: TextAlign.center,
      ),
    ],
  );
}
