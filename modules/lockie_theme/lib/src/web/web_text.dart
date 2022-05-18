import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class WebText extends StatelessWidget {

  final String data;
  final TextStyle? style;
  final WrapAlignment? align;

  /// A text widget usually used in web applications.
  /// 
  /// Treats it's [data] as markdown and is [selectable] by default.
  const WebText(this.data, { 
    Key? key,
    this.style,
    this.align
  }) : super(key: key);

  static const _style = TextStyle(
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      styleSheet: MarkdownStyleSheet(
        pPadding: const EdgeInsets.only(bottom: 10),
        h2Padding: const EdgeInsets.only(top: 10),
        textAlign: align ?? WrapAlignment.start,
        p: style != null ? _style.merge(style!) : _style,
        h1: Theme.of(context).textTheme.headline4,
        h2: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
        )
      ),
      selectable: true,
      onTapLink: (text, link, title) {
        if(link != null) {
          launchUrl(Uri.parse(link));
        }
      },
      data: data,
    );
  }
}