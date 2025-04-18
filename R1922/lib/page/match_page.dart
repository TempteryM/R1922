import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mobileads/mobile_ads.dart';
import 'football/Football_match.dart';
import 'hockey/hockey_match.dart';
import '../providers/navbar_provider.dart';
import '../constants/language.dart';

class MatchViewScreen extends StatefulWidget {
  const MatchViewScreen({super.key});
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
    MobileAds.initialize();

    if (this.mounted) {
      // check whether the state object is in tree
      setState(() {
        // make changes here
      });
    }
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

  void someAsyncOperation() async {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Инициализация ScreenUtil здесь
    ScreenUtil.init(context, designSize: const Size(360, 690));
  }

  void onItemTapped(int index) {
    setState(() {
      Provider.of<NavbarProvider>(context, listen: false).selectedIndex = index;
    });
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
          flexibleSpace: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).colorScheme.onBackground,
                    spreadRadius: 0.0.h,
                    blurRadius: 0.h),
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
            dividerColor: Colors.grey[300],
            indicatorColor: Colors.transparent,
            unselectedLabelColor: Colors.black,
            labelStyle: Theme.of(context).textTheme.titleMedium,
            tabs: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: _textFootball(context)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _textHockey(context)),
                ],
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              FootballMatchScreen(),
              HockeyMatchScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _textTitleBar(context) {
  return Text(Language.matchData,
      style: Theme.of(context).textTheme.labelLarge);
}

Widget _textFootball(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
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
        textAlign: TextAlign.start,
      ),
    ],
  );
}

Widget _textHockey(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
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
        textAlign: TextAlign.start,
      ),
    ],
  );
}
