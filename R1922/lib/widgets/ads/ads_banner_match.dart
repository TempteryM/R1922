import 'package:yandex_mobileads/mobile_ads.dart';
import 'package:flutter/material.dart';

class BannerAdPageMatch extends StatelessWidget {
  BannerAdPageMatch({
    Key? key,
    this.bannerAdd,
  }) : super(key: key);
  final Widget? bannerAdd;

  final bannerMatch = BannerAd(
    adUnitId: 'demo-banner-yandex', //'R-M-2480222-4',

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
          bannerAd: bannerMatch,
        ),
      ),
    );
  }
}
