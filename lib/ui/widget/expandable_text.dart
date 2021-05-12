import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assist/flutter_assist.dart';

/// @author zdl
/// date 2021/1/20 13:57
/// email zdl328465042@163.com
/// description 可收起、展开的text
class ZExpandableText extends StatefulWidget {
  final String data;
  final TextStyle style;
  final int maxLines;
  final String expandText;
  final String collapseText;
  final TextStyle linkStyle;
  final bool expanded;
  final TextAlign textAlign;

  const ZExpandableText(
    this.data, {
    this.style,
    this.maxLines,
    this.expandText,
    this.collapseText,
    this.linkStyle,
    this.expanded,
    this.textAlign,
  }) : assert(data != null);

  @override
  _ZExpandableTextState createState() => _ZExpandableTextState();
}

class _ZExpandableTextState extends State<ZExpandableText> {
  bool _expanded;
  TapGestureRecognizer _linkTapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _expanded = widget.expanded ?? ZConfigExpandableText.expanded;
    _linkTapGestureRecognizer = TapGestureRecognizer()..onTap = () => setState(() => _expanded = !_expanded);
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defStyle = DefaultTextStyle.of(context);
    TextStyle effectiveStyle = widget.style;
    if (effectiveStyle == null || effectiveStyle.inherit) {
      effectiveStyle = defStyle.style.merge(effectiveStyle);
    }

    final linkText = _expanded ? widget.collapseText ?? ZConfigExpandableText.collapseText : widget.expandText ?? ZConfigExpandableText.expandText;
    final linkColor = widget.linkStyle?.color ?? Colors.blue;
    final linkStyle = effectiveStyle.merge(widget.linkStyle).copyWith(color: linkColor);

    final link = TextSpan(
      children: [
        if (!_expanded)
          TextSpan(
            text: '…',
            style: effectiveStyle,
          ),
        if (linkText.isNotEmpty)
          TextSpan(
            style: linkStyle,
            text: ' $linkText',
            recognizer: _linkTapGestureRecognizer,
          ),
      ],
    );

    final text = TextSpan(
      text: widget.data,
      style: effectiveStyle,
    );

    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double minWidth = constraints.minWidth;
        final double maxWidth = constraints.maxWidth;

        final textAlign = widget.textAlign ?? defStyle.textAlign ?? TextAlign.start;

        TextPainter tp = TextPainter(
          text: link,
          textAlign: textAlign,
          maxLines: widget.maxLines ?? ZConfigExpandableText.maxLines,
          textDirection: TextDirection.ltr,
        );
        tp.layout(minWidth: minWidth, maxWidth: maxWidth);
        final linkSize = tp.size;

        tp.text = text;
        tp.layout(minWidth: minWidth, maxWidth: maxWidth);
        final textSize = tp.size;

        TextSpan textSpan;
        if (tp.didExceedMaxLines) {
          final position = tp.getPositionForOffset(Offset(
            textSize.width - linkSize.width,
            textSize.height,
          ));
          final endOffset = tp.getOffsetBefore(position.offset) ?? 0;

          textSpan = TextSpan(
            text: _expanded ? widget.data : widget.data.substring(0, max(endOffset, 0)),
            style: effectiveStyle,
            children: [link],
          );
        } else {
          textSpan = text;
        }

        return RichText(
          text: textSpan,
          softWrap: true,
          textAlign: textAlign,
          overflow: TextOverflow.clip,
        );
      },
    );

    return result;
  }
}
