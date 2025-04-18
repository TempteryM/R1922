import 'dart:async';
import 'package:com.gds.radio1922/widgets/ads/ads_new.dart';
import 'package:com.gds.radio1922/widgets/custom_container_black.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yandex_mobileads/mobile_ads.dart';
import '../models/about/user_api_service.dart';
import '../models/cache/cache_clear_button.dart';
import '../widgets/appbar/Custom_SliverAppBar.dart';
import '../widgets/background.dart';
import '../constants/config.dart';
import '../models/markdown_models.dart';
import '../constants/language.dart';
import '../models/about/user_about.dart';

class AboutViewScreen extends StatefulWidget {
  const AboutViewScreen({super.key});
  static const routeName = '/about';

  @override
  State<AboutViewScreen> createState() => _AboutViewScreenState();
}

class _AboutViewScreenState extends State<AboutViewScreen> {
  final UserApiService _apiService = UserApiService();
  late Future<List<User>> usersFuture;

  @override
  void initState() {
    super.initState();
    usersFuture = _apiService.getUsers();
    MobileAds.initialize();
    if (this.mounted) {
      // check whether the state object is in tree
      setState(() {
        // make changes here
      });
    }
  }

  void someAsyncOperation() async {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Scaffold(
      primary: true,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            CustomSilverAppBar(
              titleWidget: _textAboutUs(context),
              actionWidget: _privacyButton(context),
            )
          ];
        },
        body: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return CustomBackgroundApp(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 0.h, vertical: 0.5.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildProfileContainer(context),
            SizedBox(height: 3.h),
            _buildDescriptionContainer(context),
            _teamText(context),
            FutureBuilder<List<User>>(
              future: usersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  final users = snapshot.data!;
                  return buildUsersCard(users);
                } else {
                  return Padding(
                    padding: EdgeInsets.all(8.0.h),
                    child: const Text('Загрузка...'),
                  );
                }
              },
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10.h, top: 3.h),
              child: Column(
                children: [
                  const Text(
                    "App by G.D.S. Temptery M.",
                  ),
                  CacheClearButton(
                    boxNames: [
                      'user_cache',
                      'football_cache',
                      'hockey_cache',
                      'news_cache'
                    ],
                    lastFetchTimeKeys: [
                      'lastFetchTime_user',
                      'lastFetchTime_news',
                      'lastFetchTimes_hockey',
                      'lastFetchTimes_football'
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5.h),
              child: AdBanner(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textAboutUs(context) {
    return Text(Language.aboutUs, style: Theme.of(context).textTheme.bodyLarge);
  }

  Widget _buildProfileContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Text(
              appNameScreen,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Text(
            aboutTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  Widget _teamText(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Center(
        child: Text(
          'КОМАНДА КРАСНО-БЕЛОЙ ВОЛНЫ',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  Widget _buildDescriptionContainer(BuildContext context) {
    return CustomContainerBlack(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: MarkdownText(
          filename: 'assets/text/about.md',
          textStyle: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

// Кнопка политики конфиденциальности
  Widget _privacyButton(context) {
    return IconButton(
        icon: Icon(
          Icons.privacy_tip_outlined,
          color: Theme.of(context).colorScheme.onSurface,
          size: 20.sp,
        ),
        onPressed: () => _dialogBuilder(context));
  }

// Диалоговое окно политики конфиденциальности
  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.onBackground,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          title: Text(
            "Политика конфиденциальности",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.h),
          content: _buildDialogContent(context),
          actions: <Widget>[
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: Text(
                  'ПРИНЯТЬ',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return SizedBox(
      height: 500.h,
      width: 300.h,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MarkdownText(
            filename: 'assets/text/privacy_policy.md',
            textStyle: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ),
    );
  }

// Карточки с командой
  Widget buildUsersCard(List<User> users) => ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return _buildUserCard(context, user);
      });

  Widget _buildUserCard(BuildContext context, User user) {
    return CustomContainerBlack(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildAvatar(context, user.urlAvatar),
          Expanded(
            child: _buildUserInfo(context, user),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, String urlAvatar) {
    return Padding(
        padding: EdgeInsets.only(left: 15.h),
        child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(60.0
                  .h), // Используем радиус 30, чтобы он подходил под размер.
              border: Border.all(
                  width: 0.05.h, color: Theme.of(context).colorScheme.primary),
            ),
            child: Padding(
              padding: EdgeInsets.all(0.8.h),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: 50.h,
                  maxWidth: 50.h,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/images/logo.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ClipOval(
                  child: Image.network(
                    urlAvatar,
                    width: 50.h, // Устанавливаем ширину
                    height: 50.h, // Устанавливаем высоту
                    fit: BoxFit.cover, // Подгонка изображения по размеру
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                          child: Icon(Icons.error)); // Показывать иконку ошибки
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                          child:
                              CircularProgressIndicator()); // Индикатор загрузки
                    },
                  ),
                ),
              ),
            )));
  }

  Widget _buildUserInfo(BuildContext context, User user) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: Text(
              user.userName,
              style: Theme.of(context).textTheme.titleLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Divider(
            height: 0.5.h,
            color: Theme.of(context).colorScheme.primary,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Text(
              user.team,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ],
      ),
    );
  }
}
