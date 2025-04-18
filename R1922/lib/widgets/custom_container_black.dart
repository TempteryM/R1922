import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContainerBlack extends StatelessWidget {
  final Widget child;
  final double? height; // Высота контейнера
  final double? width; // Ширина контейнера

  const CustomContainerBlack({
    Key? key,
    required this.child,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 9.h, vertical: 5.h),
      child: Container(
        constraints: BoxConstraints(),
        padding: EdgeInsets.only(left: 3.h, right: 3.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: const Color.fromARGB(255, 134, 134, 134),
                spreadRadius: 0.1.h,
                blurRadius: 0.1.h),
          ],
          border: Border.all(
            width: 0.3.h,
            color: Theme.of(context).colorScheme.surface,
          ),
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.all(
            Radius.elliptical(10.h, 10.h),
          ),
          gradient: LinearGradient(
            tileMode: TileMode.clamp,
            colors: [
              Theme.of(context).colorScheme.onBackground,
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.onBackground,
            ],
            stops: [0.5.h, 0.5.h, 0.5.h],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: child,
      ),
    );
  }
}
