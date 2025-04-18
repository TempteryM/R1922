import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContainerWhite extends StatelessWidget {
  final Widget child;
  final double? height; // Высота контейнера
  final double? width; // Ширина контейнера

  const CustomContainerWhite({
    Key? key,
    required this.child,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.h, vertical: 0.h),
      child: Container(
        constraints: BoxConstraints(),
        padding: EdgeInsets.only(
          top: 3.h,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).colorScheme.primary,
                spreadRadius: 0.5.h,
                blurRadius: 1.h),
          ],
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.all(
            Radius.elliptical(0.h, 0.h),
          ),
          gradient: LinearGradient(
            tileMode: TileMode.clamp,
            colors: [
              Theme.of(context).colorScheme.onSurface,
            ],
            stops: [
              1.h,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: child,
      ),
    );
  }
}
