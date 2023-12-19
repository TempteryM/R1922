import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../models/player_models.dart';

class ControlButton extends StatefulWidget {
  const ControlButton({super.key});

  @override
  State<ControlButton> createState() => _ControlButtonState();
}

class _ControlButtonState extends State<ControlButton> {
  late final viewModel = Provider.of<PlayerScreenModel>(context, listen: true);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          flex: 1,
          child: Card(
            color: Theme.of(context).colorScheme.secondary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(180.0.h)),
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.all(1.h),
              child: ClipOval(
                child: Material(
                  color: Theme.of(context).colorScheme.onBackground,
                  child: InkWell(
                      splashColor: Theme.of(context).colorScheme.secondary,
                      child: Container(
                        constraints: BoxConstraints(
                          maxHeight: 60.h,
                          maxWidth: 60.h,
                          minHeight: 50.h,
                          minWidth: 50.h,
                        ),
                        child: Icon(
                          viewModel.isPlaying
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          size: 40.sp,
                          color: Theme.of(context).colorScheme.surfaceTint,
                        ),
                      ),
                      onTap: () {
                        viewModel.isPlaying
                            ? viewModel.pause()
                            : viewModel.play();
                        HapticFeedback.vibrate();
                      }),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
