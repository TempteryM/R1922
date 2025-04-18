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
        gradient: LinearGradient(
          tileMode: TileMode.clamp,
          colors: [
            Theme.of(context).colorScheme.background, //
            Theme.of(context).colorScheme.onBackground,
            Theme.of(context).colorScheme.background, //
          ],
          stops: [0.0, 0.5, 1.0], // Позиции цветов на градиенте
          begin: Alignment.centerLeft, // Начало градиента с левой стороны
          end: Alignment.centerRight, // Конец градиента с правой стороны
        ),
      ),
      child: widget.child,
    );
  }
}
