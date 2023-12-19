import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:radio1922/models/macth_article.dart';

import 'package:radio1922/widgets/ads/ads_banner_match.dart';
import 'package:radio1922/widgets/background.dart';
import 'package:http/http.dart' as http;

class FootballMatch extends StatefulWidget {
  const FootballMatch({Key? key}) : super(key: key);

  @override
  State<FootballMatch> createState() => FootballMatchState();
}

class FootballMatchState extends State<FootballMatch> {
  Future<List<Match>> footballFuture = getFootball();

  static Future<List<Match>> getFootball() async {
    const url = 'http://kbvolna.com/matchapp/matchFootball.json';

    final response = await http.get(Uri.parse(url));
    final body = json.decode(utf8.decode(response.bodyBytes));

    return body.map<Match>(Match.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackgroundApp(
      child: Column(
        children: [
          FutureBuilder<List<Match>>(
            future: footballFuture,
            builder: (context, snaphot) {
              if (snaphot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: EdgeInsets.all(18.0.h),
                  child: const CircularProgressIndicator(),
                );
              }
              if (snaphot.hasData) {
                final matchs = snaphot.data!;
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: BannerAdPageMatch(),
                    ),
                    buildmatchCard(matchs),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: BannerAdPageMatch(),
                    ),
                  ],
                );
              } else {
                return Padding(
                  padding: EdgeInsets.all(8.0.h),
                  child: const Text('Загрузка...'),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildmatchCard(List<Match> matchs) => ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 5.h),
      shrinkWrap: true,
      itemCount: matchs.length,
      itemBuilder: (context, index) {
        final match = matchs[index];

        return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.h,
              vertical: 5.h,
            ),
            child: Container(
                constraints: BoxConstraints(
                  maxHeight: 100.w,
                  maxWidth: 250.w,
                  minHeight: 75.w,
                  minWidth: 75.w,
                ),
                padding: EdgeInsets.only(left: 3.h, right: 3.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        spreadRadius: 0.9.h,
                        blurRadius: 3.h),
                  ],
                  border: Border.all(
                    width: 0.5.h,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.all(
                    Radius.elliptical(20.h, 20.h),
                  ),
                  gradient: LinearGradient(
                    tileMode: TileMode.clamp,
                    colors: [
                      Theme.of(context).colorScheme.onBackground,
                      Theme.of(context).colorScheme.surface,
                      Theme.of(context).colorScheme.onBackground,
                    ],
                    stops: [0.5.h, 0.5.h, 0.5.h],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Stack(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.h, vertical: 1.h),
                                  child: Text(match.leagues,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                ))
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                    child: Padding(
                                        padding: EdgeInsets.only(left: 10.h),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SizedBox(
                                                      width: 25,
                                                      height: 25,
                                                      child: Image(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              match
                                                                  .logoTeamOne)),
                                                    ),
                                                    Center(
                                                        child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 15.h),
                                                      child: Text(match.teamOne,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    ))
                                                  ]),
                                              Row(children: [
                                                Expanded(
                                                    child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 5.h),
                                                        child: Container(
                                                          height: 0.5.h,
                                                          width: 150.h,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                        )))
                                              ]),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SizedBox(
                                                      width: 25,
                                                      height: 25,
                                                      child: Image(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              match
                                                                  .logoTeamTwo)),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 15.h),
                                                      child: Text(match.teamTwo,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    )
                                                  ])
                                            ]))),
                                Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 50.h,
                                        width: 0.5.h,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      )
                                    ]),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.h),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Center(
                                                  child: Text(match.dateDay,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall,
                                                      maxLines: 1,
                                                      overflow: TextOverflow
                                                          .ellipsis))
                                            ]),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(match.dateTime,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis)
                                            ]),
                                      ]),
                                ),
                              ]),
                        ]),
                  )
                ])));
      });
}
