import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assist/flutter_assist.dart';

/// @author zdl
/// date 2020/12/17 14:16
/// email zdl328465042@163.com
/// description 通用左右输入布局
class ZInputInfoRow extends StatelessWidget {
  final dynamic keyStr;
  final TextStyle keyStyle;
  final int keyFlex;
  final String valueStr;
  final TextStyle valueStyle;
  final int valueFlex;
  final int valueMaxLine;
  final String valueHintStr;
  final TextStyle valueHintStyle;
  final TextEditingController controller;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType inputType;
  final EdgeInsets contentPadding;
  final bool obscureText;

  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color bgColor;
  final bool valueIsEnd;
  final double centerSpace;
  final bool hasDivider;
  final Color dividerColor;
  final EdgeInsets dividerMargin;

  const ZInputInfoRow({
    this.keyStr,
    this.keyStyle,
    this.keyFlex,
    this.valueStr,
    this.valueStyle,
    this.valueFlex,
    this.valueMaxLine = 1,
    this.valueHintStr,
    this.valueHintStyle,
    this.controller,
    this.inputFormatters,
    this.inputType,
    this.contentPadding,
    this.obscureText,
    this.padding,
    this.margin,
    this.bgColor,
    this.valueIsEnd,
    this.centerSpace,
    this.hasDivider = true,
    this.dividerColor,
    this.dividerMargin,
  });

  @override
  Widget build(BuildContext context) {
    var content;
    content = Container(
      padding: padding,
      margin: margin,
      color: bgColor,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            flex: keyFlex ?? ZConfigInputInfoRow.keyFlex,
            child: keyStr is Widget
                ? keyStr
                : Text(
                    '${keyStr ?? ''}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: keyStyle ?? ZConfigInputInfoRow.keyStyle,
                  ),
          ),
          SizedBox(width: centerSpace ?? ZConfigInputInfoRow.centerSpace),
          Expanded(
            flex: valueFlex ?? ZConfigInputInfoRow.valueFlex,
            child: TextField(
              controller: controller ?? TextEditingController(text: valueStr ?? ''),
              inputFormatters: inputFormatters ?? [],
              keyboardType: inputType,
              textAlign: (valueIsEnd ?? ZConfigInputInfoRow.valueIsEnd) ? TextAlign.end : TextAlign.start,
              maxLines: valueMaxLine,
              obscureText: obscureText ?? false,
              style: valueStyle ?? ZConfigInputInfoRow.valueStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: contentPadding,
                isDense: contentPadding != null,
                hintText: valueHintStr ?? '请输入',
                hintStyle: valueHintStyle ?? ZConfigInputInfoRow.valueHintStyle,
              ),
            ),
          ),
        ],
      ),
    );
    if (hasDivider) {
      content = Column(
        children: [
          content,
          ZLine(
            lineColor: dividerColor ?? ZConfigColor.lineColor,
            margin: dividerMargin,
          ),
        ],
      );
    }
    return content;
  }
}
