import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:radio1922/widgets/Custom_SliverAppBar.dart';
import 'package:radio1922/widgets/ads/ads_banner.dart';
import 'package:radio1922/widgets/background.dart';

import '../constants/config.dart';
import '../models/markdown_models.dart';
import '../constants/language.dart';
import '../models/user_about.dart';
import 'package:http/http.dart' as http;

class AboutViewScreen extends StatefulWidget {
  const AboutViewScreen({super.key});
  static const routeName = '/about';

  @override
  State<AboutViewScreen> createState() => _AboutViewScreenState();
}

class _AboutViewScreenState extends State<AboutViewScreen> {
  set launched(Future<void> launched) {}

  Future<List<User>> usersFuture = getUsers();

  static Future<List<User>> getUsers() async {
    const url = 'https://kbvolna.com/Users.json';

    final response = await http.get(Uri.parse(url));
    final body = json.decode(utf8.decode(response.bodyBytes));

    return body.map<User>(User.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      primary: true,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
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

  Widget _buildContent(context) {
    return CustomBackgroundApp(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 0.5.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildProfileContainer(context),
            SizedBox(height: 2.h),
            _buildDescriptionContainer(context),
            _teamtext(context),
            FutureBuilder<List<User>>(
              future: usersFuture,
              builder: (context, snaphot) {
                if (snaphot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: CircularProgressIndicator(),
                  );
                }
                if (snaphot.hasData) {
                  final users = snaphot.data!;
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
              padding: EdgeInsets.only(bottom: 10.h),
              child: const Text(
                "App by G.D.S. Temptery M.",
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: BannerAdPageHead(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _textAboutUs(context) {
    return Text(Language.aboutUs,
        style: Theme.of(context).textTheme.titleLarge);
  }

  Widget _buildProfileContainer(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 10.h),
          child: Column(
            children: <Widget>[
              Text(appNameScreen, style: Theme.of(context).textTheme.bodyLarge),
              Text(aboutTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }

  Widget _teamtext(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
          child: Column(
            children: <Widget>[
              Text('КОМАНДА КРАСНО-БЕЛОЙ ВОЛНЫ',
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionContainer(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 2.h, right: 2.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black, spreadRadius: 0.8.h, blurRadius: 3.h),
            ],
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.all(
              Radius.elliptical(6.h, 6.h),
            ),
            border: Border.all(
              width: 0.5.h,
              color: Theme.of(context).colorScheme.surface,
            ),
            gradient: LinearGradient(
              tileMode: TileMode.clamp,
              colors: [
                Theme.of(context).colorScheme.onBackground,
              ],
              stops: [
                0.08.h,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: MarkdownText(
              filename: 'assets/text/about.md',
              textStyle: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ],
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
          Future.delayed(const Duration(seconds: 1000), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.onBackground,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            title: Text(
              "Политика конфиденциальности",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            contentPadding:
                EdgeInsets.only(bottom: 2.h, top: 2.h, left: 1.h, right: 1.h),
            content: SizedBox(
              height: 500.h,
              width: 280.h,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MarkdownText(
                    filename: 'assets/text/privacy_policy.md',
                    textStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ),
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
        });
  }

// Карточки с командой
  Widget buildUsersCard(List<User> users) => ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: 80.w,
              maxWidth: 80.w,
              minHeight: 40.w,
              minWidth: 40.w,
            ),
            padding: EdgeInsets.only(left: 10.h, right: 10.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black, spreadRadius: 0.8.h, blurRadius: 3.h),
              ],
              border: Border.all(
                width: 0.5.h,
                color: Theme.of(context).colorScheme.surface,
              ),
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.all(
                Radius.elliptical(10.h, 10.h),
              ),
              gradient: LinearGradient(
                tileMode: TileMode.clamp,
                colors: [
                  Theme.of(context).colorScheme.onBackground,
                ],
                stops: [
                  0.08.h,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.h),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(380.0.h),
                      border: Border.all(
                        width: 0.08.h,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(0.8.h),
                      child: Container(
                        constraints: BoxConstraints(
                          maxHeight: 55.h,
                          maxWidth: 55.h,
                          minHeight: 55.h,
                          minWidth: 55.h,
                        ),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("assets/images/logo.png"),
                              fit: BoxFit.cover),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(280.0.h),
                          child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(user.urlAvatar),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.h, vertical: 5.h),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: Text(user.userName,
                                style: Theme.of(context).textTheme.labelMedium,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                          ),
                          Container(
                            height: 0.5.h,
                            width: double.infinity,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: Text(
                              user.team,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          )
                        ]),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
