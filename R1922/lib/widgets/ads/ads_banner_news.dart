import 'package:yandex_mobileads/mobile_ads.dart';
import 'package:flutter/material.dart';

class BannerAdPageNews extends StatelessWidget {
  BannerAdPageNews({
    Key? key,
    this.bannerAdd,
  }) : super(key: key);
  final Widget? bannerAdd;

  final bannerNews = BannerAd(
    adUnitId: 'demo-banner-yandex', //'R-M-2480222-3',
    // Flex-size
    adSize: const BannerAdSize.inline(width: 360, maxHeight: 160),

    adRequest: const AdRequest(),
    onAdLoaded: () {
      /* Do something */
    },
    onAdFailedToLoad: (error) {
      /* Do something */
    },
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: AdWidget(
          bannerAd: bannerNews,
        ),
      ),
    );
  }
}
