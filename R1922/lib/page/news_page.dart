import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:radio1922/models/news_article.dart';
import 'package:radio1922/widgets/ads/ads_banner_news.dart';
import 'package:radio1922/widgets/background.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/language.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

class NewsViewScreen extends StatefulWidget {
  const NewsViewScreen({Key? key}) : super(key: key);
  static const routeName = '/news';

  @override
  State<NewsViewScreen> createState() => NewsViewScreenState();
}

class NewsViewScreenState extends State<NewsViewScreen> {
  set launched(Future<void> launched) {}
  late final viewModel = Provider.of<NewsViewScreen>(context, listen: true);

  List<Article> articles = [];

  @override
  void initState() {
    super.initState();
    getWebsiteData();
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

  Future getWebsiteData() async {
    final url = Uri.parse('http://kbvolna.com/news/');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final titles = html
        .querySelectorAll('div.news_title>a')
        .map((element) => element.innerHtml.trim())
        .toList();

    final dates = html
        .querySelectorAll('div.date')
        .map((element) => element.innerHtml.trim())
        .toList();

    final urlButton = html
        .querySelectorAll('div.news_item_content > div.txt > a')
        .map((element) => 'kbvolna.com${element.attributes['href']}')
        .toList();

    final urlImages = html
        .querySelectorAll('div.news_item_content > div.imgs > img ')
        .map((element) => 'http://kbvolna.com/${element.attributes['src']}')
        .toList();

    setState(() {
      articles = List.generate(
          titles.length,
          (index) => Article(
              title: titles[index],
              dateNews: dates[index],
              urlButton: urlButton[index],
              urlImage: urlImages[index]));
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
        body: SafeArea(child: buidContent(context)),
      ),
    );
  }

  Widget buidContent(BuildContext context) {
    return CustomBackgroundApp(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: BannerAdPageNews(),
          ),
          buildNewsCard(articles),
          Padding(
            padding: EdgeInsets.only(bottom: 10.h, top: 5.h),
            child: BannerAdPageNews(),
          )
        ],
      ),
    );
  }

  Widget buildNewsCard(List<Article> article) => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 5.h),
        shrinkWrap: true,
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];

          final Uri toNews =
              Uri(scheme: 'http', host: '', path: article.urlButton);
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.h,
              vertical: 5.h,
            ),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: 105.w,
                maxWidth: 105.w,
                minHeight: 80.w,
                minWidth: 80.w,
              ),
              padding: EdgeInsets.only(left: 2.h, right: 8.h),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      spreadRadius: 0.8.h,
                      blurRadius: 3.h),
                ],
                border: Border.all(
                  width: 0.5.h,
                  color: Theme.of(context).colorScheme.surface,
                ),
                borderRadius: BorderRadius.all(
                  Radius.elliptical(20.h, 20.h),
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
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.h),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(180.0.h),
                            border: Border.all(
                              width: 0.2.h,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(0.5.h),
                            child: Container(
                              constraints: BoxConstraints(
                                maxHeight: 80.w,
                                maxWidth: 80.w,
                                minHeight: 80.w,
                                minWidth: 80.w,
                              ),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage("assets/images/logo.png"),
                                    fit: BoxFit.cover),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(180.0.h),
                                child: Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(article.urlImage),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 5.h, right: 5.h, top: 5.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: Text(article.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    article.dateNews.toString(),
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  TextButton(
                                    child: Text(
                                      'ПОДРОБНЕЕ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    onPressed: () async {
                                      launched = _launchInBrowser(toNews);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );

  Widget _textTitleBar(context) {
    return Text(Language.newsView,
        style: Theme.of(context).textTheme.titleLarge);
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
        const Text(
          'НОВОСТИ «СПАРТАК»',
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
