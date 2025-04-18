import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../models/player_models.dart';

class CoverImg extends StatefulWidget {
  const CoverImg({super.key});

  @override
  State<CoverImg> createState() => _CoverImgState();
}

class _CoverImgState extends State<CoverImg> {
  late final viewModel = Provider.of<PlayerScreenModel>(context, listen: true);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if (isPortrait) {
      return Center(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black, spreadRadius: 0.5.h, blurRadius: 0.5.h),
            ],
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(180.0.h),
          ),
          child: Padding(
            padding: EdgeInsets.all(1.h),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: 200.h,
                  maxWidth: 200.h,
                  minHeight: 100.h,
                  minWidth: 100.h,
                ),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(180.0.h),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 100),
                    child: viewModel.artwork ??
                        Image.asset(
                          'assets/images/logo.png',
                          key: const ValueKey(0),
                          fit: BoxFit.cover,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Center(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black, spreadRadius: 0.5.h, blurRadius: 0.5.h),
            ],
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(360.0.h),
          ),
          child: Padding(
            padding: EdgeInsets.all(1.h),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: 350.h,
                  maxWidth: 350.h,
                  minHeight: 350.h,
                  minWidth: 350.h,
                ),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(360.0.h),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 100),
                    child: viewModel.artwork ??
                        Image.asset(
                          'assets/images/logo.png',
                          key: const ValueKey(0),
                          fit: BoxFit.cover,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
