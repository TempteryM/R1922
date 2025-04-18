import 'dart:async';
import 'package:com.gds.radio1922/widgets/ads/ads_new.dart';
import 'package:com.gds.radio1922/widgets/custom_container_black.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mobileads/mobile_ads.dart';
import '../models/news/news_api_service.dart';
import '../models/news/news_article.dart';
import '../providers/navbar_provider.dart';
import '../widgets/background.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/language.dart';

class NewsViewScreen extends StatefulWidget {
  const NewsViewScreen({Key? key}) : super(key: key);
  static const routeName = '/news';

  @override
  State<NewsViewScreen> createState() => NewsViewScreenState();
}

class NewsViewScreenState extends State<NewsViewScreen> {
  set launched(Future<void> launched) {}
  late final NewsApiService _apiService = NewsApiService();
  late Future<List<NewsArticle>> newsFuture;

  @override
  void initState() {
    super.initState();
    newsFuture = _apiService.getWebsiteData();
    MobileAds.initialize();
    if (this.mounted) {
      // check whether the state object is in tree
      setState(() {
        // make changes here
      });
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
      length: 1,
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
            tabs: [_textNews(context)],
          ),
        ),
        body: SafeArea(child: _buildContent(context)),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return CustomBackgroundApp(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 5.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FutureBuilder<List<NewsArticle>>(
              future: newsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  final news = snapshot.data!;

                  return buildNewsCard(news);
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: EdgeInsets.all(8.0.h),
                    child: Text('Ошибка: ${snapshot.error}'),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.all(8.0.h),
                    child: const Text('Нет данных для отображения.'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNewsCard(List<NewsArticle> news) => ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 3.h),
      shrinkWrap: true,
      itemCount: news.length,
      itemBuilder: (context, index) {
        if ((index + 1) % 4 == 0) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 3.h),
            child: AdBanner(),
          );
        } else {
          final article = news[index];
          final Uri toNews = Uri.parse(article.urlButton);
          return CustomContainerBlack(
            child: Padding(
                padding: EdgeInsets.all(6.h),
                child: Stack(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // Изображение
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(60.0
                                .h), // Используем радиус 30, чтобы он подходил под размер.
                            border: Border.all(
                                width: 0.5.h,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(0.6.h),
                            child: Container(
                              width: 70.h, // Устанавливаем ширину
                              height: 70.h, // Уста
                              constraints: BoxConstraints(),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage("assets/images/logo.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  article.urlImage,
                                  width: 70.h, // Устанавливаем ширину
                                  height: 70.h, // Устанавливаем высоту
                                  fit: BoxFit
                                      .cover, // Подгонка изображения по размеру
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                        child: Icon(Icons
                                            .error)); // Показывать иконку ошибки
                                  },
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                        child:
                                            CircularProgressIndicator()); // Индикатор загрузки
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.h),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize
                                        .min, // Заставляем элементы растягиваться
                                    children: [
                                      // Заголовок статьи с фиксированной высотой
                                      SizedBox(
                                        height: 55
                                            .w, // Фиксированная высота для заголовка
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 0.h),
                                          child: Text(
                                            article.title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign
                                                .left, // Выровнять текст по левому краю
                                          ),
                                        ),
                                      ),

                                      // Фиксированные элементы
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              height: 0.5.h,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary, // Замените на ваш цвет
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 3.h),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        article.dateNews
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall,
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          launched =
                                                              _launchInBrowser(
                                                                  toNews);
                                                        },
                                                        child: Text(
                                                          'подробнее'
                                                              .toUpperCase(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleMedium,
                                                        ),
                                                      )
                                                    ]))
                                          ])
                                    ])))
                      ])
                ])),
          );
        }
      });

  Widget _textTitleBar(context) {
    return Text(Language.newsView,
        style: Theme.of(context).textTheme.labelLarge);
  }

  Widget _textNews(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.newspaper_rounded,
          size: 20.sp,
        ),
        SizedBox(
          width: 5.h,
        ),
        Text(
          Language.newsSpartak,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
