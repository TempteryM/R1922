import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title = '',
    this.buttonLeft,
    this.buttonRight,
    this.titleWidget,
  }) : super(key: key);

  final String title;
  final Widget? titleWidget;
  final Widget? buttonLeft;
  final Widget? buttonRight;

  @override
  State<CustomAppBar> createState() => CustomAppBarState();

  @override
  Size get preferredSize => Size(double.maxFinite, 250.h);
}

class CustomAppBarState extends State<CustomAppBar> {
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
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.elliptical(450.w, 100.w),
            bottomRight: Radius.elliptical(450.w, 100.w)),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
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
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                widget.title == ''
                    ? const SizedBox()
                    : Container(
                        alignment: Alignment.topCenter,
                        child: Text(
                          widget.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                Center(
                  child: widget.titleWidget == null
                      ? const SizedBox()
                      : Center(child: widget.titleWidget!),
                ),
                SizedBox(
                  height: 1.h,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
