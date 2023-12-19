import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:radio1922/widgets/logo_image.dart';

class CustomSilverAppBar extends StatefulWidget {
  const CustomSilverAppBar({
    Key? key,
    this.titleWidget,
    this.actionWidget,
  }) : super(key: key);

  final Widget? titleWidget;
  final Widget? actionWidget;

  @override
  State<CustomSilverAppBar> createState() => CustomSilverAppBarState();
}

class CustomSilverAppBarState extends State<CustomSilverAppBar> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return SliverAppBar(
        pinned: true,
        floating: true,
        snap: false,
        forceElevated: true,
        expandedHeight: 240.h,
        elevation: 5,
        title: widget.titleWidget,
        stretch: false,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        flexibleSpace: FlexibleSpaceBar(
          expandedTitleScale: 1.5,
          collapseMode: CollapseMode.parallax,
          background: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 5,
                ),
              ],
              color: Theme.of(context).colorScheme.onBackground,
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
            child: SafeArea(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: const LogogImag(),
                    ),
                  ]),
            ),
          ),
        ),
        actions: [
          widget.actionWidget ??
              Transform.translate(
                  offset: const Offset(0, 0), child: widget.actionWidget),
        ]);
  }
}
