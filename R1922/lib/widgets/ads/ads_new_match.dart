import 'package:flutter/material.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

class AdBannerMatch extends StatefulWidget {
  const AdBannerMatch({super.key});

  @override
  _AdBannerMatchState createState() => _AdBannerMatchState();
}

class _AdBannerMatchState extends State<AdBannerMatch> {
  late BannerAd banner;
  bool isBannerAlreadyCreated = false;

  @override
  void initState() {
    super.initState();
    MobileAds.initialize();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAd(); // Загружаем баннер после того, как зависимости изменились
  }

  @override
  void dispose() {
    if (isBannerAlreadyCreated) {
      banner.destroy(); // Освобождаем ресурсы баннера
    }
    super.dispose();
  }

  Future<void> _loadAd() async {
    banner = _createBanner();
    await banner.loadAd(adRequest: const AdRequest());
    if (mounted) {
      // Проверяем, что виджет все еще вмонтирован
      setState(() {
        isBannerAlreadyCreated =
            true; // Обновляем состояние только если виджет все еще в дереве
      });
    }
  }

  BannerAd _createBanner() {
    return BannerAd(
        adUnitId: 'demo-banner-yandex', //,
        adSize: _getAdSize(),
        adRequest: const AdRequest(),
        onAdLoaded: () {
          if (!mounted) {
            banner.destroy();
            return;
          } // The ad was loaded successfully. Now it will be shown.
        },
        onAdFailedToLoad: (error) {
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
