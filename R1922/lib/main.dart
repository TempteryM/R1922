import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:radio1922/models/Analytics.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:radio1922/models/navbar_provider.dart';
import 'package:radio1922/page/navbar_screen.dart';
import '../theme/theme_constants.dart';
import '../constants/config.dart';
import '../models/player_models.dart';
import '../page/player_screens.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Analytics.init();

  // Set device orientation.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  late final playerViewModel = PlayerScreenModel();

  // Init providers.
  final providers = [
    ChangeNotifierProvider<NavbarProvider>.value(
      value: NavbarProvider(),
    ),
    ChangeNotifierProvider<PlayerScreenModel>.value(
      value: playerViewModel,
    ),
  ];

  // Init routes.
  final routes = {
    PlayerScreen.routeName: (_) => const PlayerScreen(),
  };

  WidgetsFlutterBinding.ensureInitialized();

  runApp(App(
    providers: providers,
    routes: routes,
  ));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class App extends StatefulWidget {
  const App({
    super.key,
    required this.providers,
    required this.routes,
  });

  final Map<String, Widget Function(dynamic)> routes;
  final List<SingleChildStatelessWidget> providers;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MultiProvider(
      providers: widget.providers,
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        designSize: const Size(300, 690),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorObservers: <NavigatorObserver>[observer],
          title: appNameScreen,
          routes: widget.routes,
          theme: darkTheme,
          home: const NavbarScreen(),
        ),
      ),
    );
  }
}
