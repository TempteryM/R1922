import 'package:yandex_mobileads/mobile_ads.dart';
import 'package:flutter/material.dart';

class BannerAdPageHead extends StatelessWidget {
  BannerAdPageHead({
    Key? key,
    this.bannerAdd,
  }) : super(key: key);
  final Widget? bannerAdd;

  final bannerHead = BannerAd(
    adUnitId: 'demo-banner-yandex',//'R-M-2480222-1',
    // Flex-size
    adSize: const BannerAdSize.inline(width: 360, maxHeight: 100),

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
          bannerAd: bannerHead,
        ),
      ),
    );
  }
}
