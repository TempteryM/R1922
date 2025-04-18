import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoImage extends StatefulWidget {
  const LogoImage({Key? key}) : super(key: key);

  @override
  State<LogoImage> createState() => LogoImageState();
}

class LogoImageState extends State<LogoImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black, spreadRadius: 0.02.h, blurRadius: 1.h),
        ],
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(180.0.h),
        border: Border.all(
          width: 0.03.h,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(2.h),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: 150.h,
            maxWidth: 150.h,
            minHeight: 150.h,
            minWidth: 150.h,
          ),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover, // Подгонка изображения по размеру
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Text('Image not found'));
              },
            ),
          ),
        ),
      ),
    );
  }
}
