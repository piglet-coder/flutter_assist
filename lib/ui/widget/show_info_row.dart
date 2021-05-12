import 'package:flutter/material.dart';
import 'package:flutter_assist/flutter_assist.dart';

/// @author zdl
/// date 2020/12/7 11:26
/// email zdl328465042@163.com
/// description 通用左右显示布局
class ZShowInfoRow extends StatelessWidget {
  final dynamic keyStr;
  final TextStyle keyStyle;
  final int keyFlex;
  final String valueStr;
  final TextStyle valueStyle;
  final int valueFlex;
  final int valueMaxLine;
  final Widget rightIcon;

  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color bgColor;
  final bool valueIsEnd;
  final double centerSpace;
  final bool hasDivider;
  final Color dividerColor;
  final EdgeInsets dividerMargin;
  final VoidCallback onTap;
  final double rightIconSpace;

  const ZShowInfoRow({
    this.keyStr,
    this.keyStyle,
    this.keyFlex,
    this.valueStr,
    this.valueStyle,
    this.valueFlex,
    this.valueMaxLine = 1,
    this.rightIcon,
    this.padding,
    this.margin,
    this.bgColor,
    this.valueIsEnd,
    this.centerSpace,
    this.hasDivider = true,
    this.dividerColor,
    this.dividerMargin,
    this.onTap,
    this.rightIconSpace,
  });

  @override
  Widget build(BuildContext context) {
    var content;
    content = Container(
      padding: padding ?? ZConfigShowInfoRow.padding,
      margin: margin,
      color: bgColor,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            flex: keyFlex ?? ZConfigShowInfoRow.keyFlex,
            child: keyStr is Widget
                ? keyStr
                : Text(
                    '${keyStr ?? ''}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: keyStyle ?? ZConfigShowInfoRow.keyStyle,
                  ),
          ),
          SizedBox(width: centerSpace ?? ZConfigShowInfoRow.centerSpace),
          Expanded(
            flex: valueFlex ?? ZConfigShowInfoRow.valueFlex,
            child: Text(
              valueStr ?? '',
              textAlign: (valueIsEnd ?? ZConfigShowInfoRow.valueIsEnd) ? TextAlign.end : TextAlign.start,
              maxLines: valueMaxLine,
              overflow: TextOverflow.ellipsis,
              style: valueStyle ?? ZConfigShowInfoRow.valueStyle,
            ),
          ),
          Visibility(
            visible: onTap != null,
            child: Container(
              margin: EdgeInsets.only(left: rightIconSpace ?? ZConfigShowInfoRow.rightIconSpace),
              child: rightIcon ?? ZConfigShowInfoRow.rightIcon,
            ),
          ),
        ],
      ),
    );
    if (hasDivider) {
      content = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          content,
          ZLine(
            lineColor: dividerColor ?? ZConfigColor.lineColor,
            margin: dividerMargin,
          ),
        ],
      );
    }
    if (onTap != null) {
      content = InkWell(
        onTap: onTap,
        child: content,
      );
    }
    return content;
  }
}
