import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBarR extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBarR({
    Key? key,
    this.title,
    this.buttonLeft,
    this.buttonRight,
    this.titleWidget,
  }) : super(key: key);

  final Widget? title;
  final Widget? titleWidget;
  final Widget? buttonLeft;
  final Widget? buttonRight;

  @override
  State<CustomAppBarR> createState() => CustomAppBarState();

  @override
  Size get preferredSize => Size(double.maxFinite, 50.h);
}

class CustomAppBarState extends State<CustomAppBarR> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black, spreadRadius: 0.9.h, blurRadius: 5.h),
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
      child: SafeArea(
        child: Stack(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.buttonLeft ??
                      Transform.translate(
                        offset: const Offset(0, 0),
                        child: Container(
                            constraints: BoxConstraints(
                              maxHeight: 15.h,
                              maxWidth: 15.h,
                              minHeight: 12.h,
                              minWidth: 12.h,
                            ),
                            child: widget.buttonLeft),
                      ),
                  widget.buttonRight ??
                      Transform.translate(
                        offset: const Offset(0, 0),
                        child: Container(
                            constraints: BoxConstraints(
                              maxHeight: 15.h,
                              maxWidth: 15.h,
                              minHeight: 12.h,
                              minWidth: 12.h,
                            ),
                            child: widget.buttonRight),
                      ),
                ]),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.title ??
                    Transform.translate(
                      offset: const Offset(0, 0),
                      child: Container(
                          alignment: Alignment.topCenter, child: widget.title),
                    ),
                Center(
                  child: widget.titleWidget == null
                      ? const SizedBox()
                      : Center(child: widget.titleWidget!),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
