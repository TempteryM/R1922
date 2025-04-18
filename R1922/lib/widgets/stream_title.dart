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
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    if (isPortrait) {
      return Expanded(
        child: SizedBox(
          height: 60.w,
          width: 120.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildMarqueeOrText(
                  viewModel.artist, Theme.of(context).textTheme.labelMedium),
              Divider(
                height: 0.5.w,
                thickness: 0.5.w,
                color: Theme.of(context).colorScheme.primary,
              ),
              _buildMarqueeOrText(
                  viewModel.track, Theme.of(context).textTheme.labelSmall),
            ],
          ),
        ),
      );
    }

    // Вернуть что-то для ландшафтной ориентации, если это необходимо
    return Container(); // или другой виджет
  }

  Widget _buildMarqueeOrText(String text, TextStyle? style) {
    return Center(
      child: _willTextOverflow(text: text, style: TextTheme(bodySmall: style))
          ? Marquee(
              text: text,
              style: style,
              blankSpace: 120.w,
              velocity: 50,
              showFadingOnlyWhenScrolling: true,
              fadingEdgeStartFraction: 0.5.w,
              fadingEdgeEndFraction: 0.5.w,
              startPadding: 10.0.w,
              accelerationCurve: Curves.linear,
              decelerationCurve: Curves.easeOut,
            )
          : Text(
              text,
              maxLines: 1,
              style: style,
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
