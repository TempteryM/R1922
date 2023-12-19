import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBackgroundApp extends StatefulWidget {
  const CustomBackgroundApp({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  State<CustomBackgroundApp> createState() => CustomBackgroundAppState();
}

class CustomBackgroundAppState extends State<CustomBackgroundApp> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onBackground,
        gradient: LinearGradient(
          tileMode: TileMode.clamp,
          colors: [
            Theme.of(context).colorScheme.onBackground,
            Theme.of(context).colorScheme.surface,
            Theme.of(context).colorScheme.secondary,
          ],
          stops: [2.h, 0.5.h, 2.h],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 0.h, vertical: 0.h),
          child: widget.child),
    );
  }
}
