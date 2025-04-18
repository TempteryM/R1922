import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:yandex_mobileads/mobile_ads.dart';
import '../generated/codegen_loader.g.dart';
import '../models/about/user_about.dart';
import 'models/football/match_future/football_hive.dart';
import 'models/hockey/match_future/hockey_hive.dart';
import '../models/news/news_article.dart';
import '../providers/navbar_provider.dart';
import '../page/navbar_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../theme/theme_constants.dart';
import '../constants/config.dart';
import '../models/player_models.dart';
import '../page/player_screens.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  await MobileAds.initialize();
  await ScreenUtil.ensureScreenSize();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(NewsArticleAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(FootabllHiveAdapter());
  Hive.registerAdapter(FixtureAdapter());
  Hive.registerAdapter(LeagueAdapter());
  Hive.registerAdapter(TeamsAdapter());
  Hive.registerAdapter(GoalsAdapter());
  Hive.registerAdapter(ScoreAdapter());
  Hive.registerAdapter(PeriodsAdapter());
  Hive.registerAdapter(VenueAdapter());
  Hive.registerAdapter(StatusAdapter());
  Hive.registerAdapter(HockeyHiveAdapter());
  Hive.registerAdapter(TeamsHAdapter());
  Hive.registerAdapter(StatusHAdapter());
  Hive.registerAdapter(LeagueHAdapter());
  Hive.registerAdapter(PeriodsHAdapter());
  Hive.registerAdapter(CountryHAdapter());
  Hive.registerAdapter(ScoresHAdapter());

  // Set device orientation.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize player view model.
  final playerViewModel = PlayerScreenModel();

  // Initialize providers.
  final providers = [
    ChangeNotifierProvider<NavbarProvider>(
      create: (_) => NavbarProvider(),
    ),
    ChangeNotifierProvider<PlayerScreenModel>(
      create: (_) => playerViewModel,
    ),
  ];

  // Initialize routes.
  final routes = {
    PlayerScreen.routeName: (_) => const PlayerScreen(),
  };

  // Run the app.
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('ru'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('ru'),
      assetLoader: CodegenLoader(),
      startLocale: Locale('ru'),
      child: App(
        providers: providers,
        routes: routes,
      ),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class App extends StatelessWidget {
  const App({
    super.key,
    required this.providers,
    required this.routes,
  });

  final Map<String, Widget Function(dynamic)> routes;
  final List<SingleChildWidget> providers;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MultiProvider(
      providers: providers,
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        designSize: const Size(300, 690),
        child: MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          title: appNameScreen,
          routes: routes,
          theme: darkTheme,
          home: const NavbarScreen(),
        ),
      ),
    );
  }
}
