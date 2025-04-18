import 'dart:async';
import 'package:com.gds.radio1922/widgets/ads/ads_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mobileads/mobile_ads.dart';
import '../constants/config.dart';
import '../providers/navbar_provider.dart';
import '../widgets/appbar/custom_appbar_r.dart';
import '../widgets/background.dart';
import '../widgets/appbar/custom_appbar.dart';
import '../widgets/cover_img.dart';
import '../widgets/stream_title.dart';
import 'package:share_plus/share_plus.dart';
import '../models/player_models.dart';
import '../widgets/control_button.dart';
import '../widgets/social_network.dart';
import 'about_us.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  static const routeName = '/player';

  @override
  PlayerScreenState createState() => PlayerScreenState();
}

class PlayerScreenState extends State<PlayerScreen> {
  late final viewModel = Provider.of<PlayerScreenModel>(context, listen: true);

  Timer? timer;

  get svgFileName => null;

  @override
  void initState() {
    MobileAds.initialize();
    timer = Timer.periodic(
        const Duration(seconds: 45),
        (Timer t) => setState(() {
              AdBanner();
            }));
    if (this.mounted) {
      // check whether the state object is in tree
      setState(() {
        // make changes here
      });
    }
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    AdBanner();
    timer?.cancel();
    super.dispose();
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
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if (isPortrait) {
      return Stack(children: <Widget>[
        const CustomBackgroundApp(),
        Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          appBar: CustomAppBar(
            title: appBarName(context),
            titleWidget: const CoverImg(),
            buttonLeft: aboutButton(context),
            buttonRight: shareButton(context),
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                      horizontal: 3.h,
                      vertical: 1.h,
                    )),
                    SizedBox(
                      height: 10.h,
                    ),
                    const Row(
                      children: <Widget>[
                        StreamTitle(),
                      ],
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    const SocialNetworkUrl(),
                    SizedBox(
                      height: 25.h,
                    ),
                    const ControlButton(),
                  ],
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: AdBanner(),
                    )),
              ],
            ),
          ),
        )
      ]);
    } else {
      return Stack(
        children: [
          const CustomBackgroundApp(),
          Scaffold(
              extendBody: true,
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.transparent,
              appBar: CustomAppBarR(
                title: appBarName(context),
                buttonLeft: aboutButton(context),
                buttonRight: shareButton(context),
              ),
              body: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.h),
                          child: const CoverImg(),
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 15.h),
                              child: AdBanner(),
                            )),
                      ],
                    ),
                    Column(
                      children: [StreamTitle(), ControlButton()],
                    )
                  ],
                ),
              ))
        ],
      );
    }
  }

  Widget aboutButton(contaxt) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if (isPortrait) {
      return IconButton(
        icon: Icon(
          Icons.info_outline,
          color: Theme.of(context).colorScheme.onSurface,
          size: 20.sp,
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AboutViewScreen()),
        ),
      );
    } else {
      return IconButton(
        icon: Icon(
          Icons.info_outline,
          color: Theme.of(context).colorScheme.onSurface,
          size: 10.sp,
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AboutViewScreen()),
        ),
      );
    }
  }

  Widget appBarName(context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if (isPortrait) {
      return Text(
        appNameScreen,
        style: Theme.of(context).textTheme.labelMedium,
      );
    } else {
      return Text(
        appNameScreen,
        style: Theme.of(context).textTheme.labelMedium,
      );
    }
  }

  Widget shareButton(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    double iconSize = isPortrait ? 20.sp : 10.sp; // Установить размер иконки

    return IconButton(
      icon: Icon(
        Icons.share_outlined,
        color: Theme.of(context).colorScheme.onSurface,
        size: iconSize,
      ),
      onPressed: () {
        _onShare(context);
      },
    );
  }

  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;

    try {
      await Share.share(
        '$textShare $appNameScreen $linkStore',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    } catch (e) {
      // Обработка ошибок, если необходимо
      print("Ошибка при попытке поделиться: $e");
    }
  }
}
