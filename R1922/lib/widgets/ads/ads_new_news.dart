import 'package:flutter/material.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

class AdBannerNews extends StatefulWidget {
  const AdBannerNews({super.key});

  @override
  _AdBannerNewsState createState() => _AdBannerNewsState();
}

class _AdBannerNewsState extends State<AdBannerNews> {
  late BannerAd banner;
  bool isBannerAlreadyCreated = false;

  @override
  void initState() {
    super.initState();
    MobileAds.initialize();
    if (mounted) {
      setState(() {
        // make your changes here
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAd(); // Загружаем баннер после того, как зависимости изменились
  }

  @override
  void dispose() {
    if (isBannerAlreadyCreated) {
      banner.destroy();
    }
    banner.destroy(); // Освобождаем ресурсы баннера
    super.dispose();
  }

  _loadAd() async {
    banner = _createBanner();
    setState(() {
      isBannerAlreadyCreated = true;
    });
    // if banner is already created, you can just call
    // banner.loadAd(adRequest: const AdRequest());
  }

  BannerAd _createBanner() {
    return BannerAd(
        adUnitId: 'demo-banner-yandex',
        adSize: _getAdSize(),
        adRequest: const AdRequest(),
        onAdLoaded: () {
          if (!mounted) {
            banner.destroy();
            return;
          } // The ad was loaded successfully. Now it will be shown.
        },
        onAdFailedToLoad: (error) {
          banner.destroy();
          // Ad failed to load with AdRequestError.
          // Attempting to load a new ad from the onAdFailedToLoad() method is strongly discouraged.
        },
        onAdClicked: () {
          // Called when a click is recorded for an ad.
        },
        onLeftApplication: () {
          // Called when user is about to leave application (e.g., to go to the browser), as a result of clicking on the ad.
        },
        onReturnedToApplication: () {
          // Called when user returned to application after click.
        },
        onImpression: (impressionData) {
          // Called when an impression is recorded for an ad.
        });
  }

  BannerAdSize _getAdSize() {
    final screenWidth = MediaQuery.of(context).size.width.round();
    return BannerAdSize.sticky(width: screenWidth);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: isBannerAlreadyCreated ? AdWidget(bannerAd: banner) : null);
  }
}
