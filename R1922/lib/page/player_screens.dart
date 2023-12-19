import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:radio1922/constants/config.dart';
import 'package:radio1922/widgets/ads/ads_banner.dart';
import 'package:radio1922/widgets/background.dart';
import 'package:radio1922/widgets/custom_appbar.dart';
import 'package:radio1922/widgets/cover_img.dart';
import 'package:radio1922/widgets/stream_title.dart';
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

  get svgFileName => null;

  @override
  void initState() {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));

    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Stack(children: <Widget>[
      const CustomBackgroundApp(),
      Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          title: appNameScreen,
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
                    child: BannerAdPageHead(),
                  )),
            ],
          ),
        ),
      )
    ]);
  }

  Widget aboutButton(contaxt) {
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
  }

  Widget shareButton(context) {
    return IconButton(
      icon: Icon(
        Icons.share_outlined,
        color: Theme.of(context).colorScheme.onSurface,
        size: 20.sp,
      ),
      onPressed: () {
        Navigator.of(context).canPop();

        _onShare(context);
      },
    );
  }

  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;

    await Share.shareWithResult('$textShare $appNameScreen $linkStore',

        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}
