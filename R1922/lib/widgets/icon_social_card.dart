import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconSocialCard extends StatefulWidget {
  const IconSocialCard({
    Key? key,
    this.iconCard,
  }) : super(key: key);
  final Widget? iconCard;

  @override
  State<IconSocialCard> createState() => _IconSocialCardState();
}

class _IconSocialCardState extends State<IconSocialCard> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Flexible(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Card(
          color: Theme.of(context).colorScheme.onBackground,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 0.5.w,
              color: Theme.of(context).colorScheme.primary,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10.h),
            ),
          ),
          child: ClipOval(
            child: Material(
              color: Theme.of(context).colorScheme.surface,
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    gradient: LinearGradient(
                      tileMode: TileMode.clamp,
                      colors: [
                        Theme.of(context).colorScheme.onBackground,
                        Theme.of(context).colorScheme.onBackground,
                        Theme.of(context).colorScheme.surface
                      ],
                      stops: [0.3.h, 1.h, 1.h],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  constraints: BoxConstraints(
                    maxHeight: 35.h,
                    maxWidth: 35.h,
                    minHeight: 30.h,
                    minWidth: 30.h,
                  ),
                  child: widget.iconCard ??
                      Transform.translate(
                        offset: const Offset(-5, 0),
                        child: widget.iconCard,
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
