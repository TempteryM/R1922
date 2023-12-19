import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import '../models/player_models.dart';

class StreamTitle extends StatefulWidget {
  const StreamTitle({super.key});

  @override
  State<StreamTitle> createState() => _StreamTitleState();
}

class _StreamTitleState extends State<StreamTitle> {
  late final viewModel = Provider.of<PlayerScreenModel>(context, listen: true);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Expanded(
      child: SizedBox(
        height: 60.w,
        width: 120.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(child: SizedBox(child: Builder(
              builder: (context) {
                if (_willTextOverflow(
                  text: viewModel.artist,
                  style: TextTheme(
                      bodySmall: Theme.of(context).textTheme.labelMedium),
                )) {
                  return SizedBox(
                    child: Center(
                      child: Marquee(
                        text: viewModel.artist,
                        style: Theme.of(context).textTheme.labelMedium,
                        blankSpace: 120,
                        velocity: 50,
                        showFadingOnlyWhenScrolling: true,
                        fadingEdgeStartFraction: 0.5.w,
                        fadingEdgeEndFraction: 0.5.w,
                        startPadding: 10.0.w,
                        accelerationCurve: Curves.linear,
                        decelerationCurve: Curves.easeOut,
                      ),
                    ),
                  );
                } else {
                  return SizedBox(
                    child: Center(
                      child: Text(
                        viewModel.artist,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  );
                }
              },
            ))),
            Expanded(
              flex: 0,
              child: Container(
                height: 0.5.w,
                width: 300.w,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Expanded(child: SizedBox(child: Builder(
              builder: (context) {
                if (_willTextOverflow(
                  text: viewModel.track,
                  style: TextTheme(
                      bodySmall: Theme.of(context).textTheme.labelSmall),
                )) {
                  return SizedBox(
                    child: Center(
                      child: Marquee(
                        text: viewModel.track,
                        style: Theme.of(context).textTheme.labelSmall,
                        blankSpace: 120.w,
                        velocity: 50.w,
                        showFadingOnlyWhenScrolling: true,
                        fadingEdgeStartFraction: 0.5.w,
                        fadingEdgeEndFraction: 0.5.w,
                        startPadding: 15.0.w,
                        accelerationCurve: Curves.linear,
                        decelerationCurve: Curves.easeOut,
                      ),
                    ),
                  );
                } else {
                  return SizedBox(
                    child: Center(
                      child: Text(viewModel.track,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.labelSmall),
                    ),
                  );
                }
              },
            ))),
          ],
        ),
      ),
    );
  }

  bool _willTextOverflow({required String text, required TextTheme style}) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 1.w, maxWidth: 300.w);

    return textPainter.didExceedMaxLines;
  }
}
