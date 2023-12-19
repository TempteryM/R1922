import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/language.dart';

class Markdown extends StatelessWidget {
  const Markdown({
    super.key,
    required this.filename,
  });

  final String filename;
  final EdgeInsetsGeometry padding = const EdgeInsets.all(10);
  final TextStyle textStyle =
      const TextStyle(fontSize: 12, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
      child: SizedBox(
        height: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: padding,
                child: MarkdownText(
                  filename: filename,
                  textStyle: textStyle,
                ),
              ),
            ),
            Row(
              children: [
                const Spacer(),
                TextButton(
                  child: const Text(Language.privacyPolicyClose),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MarkdownText extends StatelessWidget {
  const MarkdownText({
    super.key,
    required this.filename,
    this.textStyle,
  });

  final String filename;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    if (textStyle != null) {
      // ignore: deprecated_member_use
      textTheme = TextTheme(bodyText2: Theme.of(context).textTheme.bodySmall);
    }

    return FutureBuilder<String>(
      future: rootBundle.loadString(filename),
      builder: (context, snapshot) {
        if (snapshot.hasData == true) {
          return MarkdownBody(
            styleSheet: MarkdownStyleSheet.fromTheme(
              ThemeData(
                textTheme: textTheme,
              ),
            ),
            data: snapshot.data!,
            onTapLink: (text, url, title) {
              launch(url!);
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
