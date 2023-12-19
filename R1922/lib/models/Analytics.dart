import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:radio1922/firebase_options.dart';

class Analytics {
  Analytics._();

  // Generate an instance of the firebase analytics class
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  // Create an instance of this class as a singleton
  static final Analytics _instance = Analytics._();

  // Initialise firebase for the app
  static Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    getData().setAnalyticsCollectionEnabled(true);
  }

  //Get the FirebaseAnalystics object to do event logging
  static FirebaseAnalytics getData() {
    return _instance.analytics;
  }
}
