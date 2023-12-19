import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogogImag extends StatefulWidget {
  const LogogImag({super.key});

  @override
  State<LogogImag> createState() => LogogImagState();
}

class LogogImagState extends State<LogogImag> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(180.0.h),
            child: Image.asset(
              'assets/images/logo.png',
            ),
          ),
        ),
      ),
    );
  }
}
