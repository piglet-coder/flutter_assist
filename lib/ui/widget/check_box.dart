import 'package:flutter/material.dart';
import 'package:flutter_assist/flutter_assist.dart';

/// @author zdl
/// date 2021/1/15 17:15
/// email zdl328465042@163.com
/// description 自定义样式的复选框
class ZCheckBox extends StatefulWidget {
  final bool value;
  final dynamic tag;
  final ValueChanged<bool?>? onChanged;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Alignment? alignment;
  final String data;
  final TextStyle? checkedStyle;
  final Decoration? checkedDecoration;
  final TextStyle? uncheckedStyle;
  final Decoration? uncheckedDecoration;

  final bool noBox;
  final bool tristate;
  final Widget? checkIcon;
  final Widget? uncheckIcon;
  final Widget? indeterminateCheckIcon;
  final double? drawablePadding;
  final Color? checkColor;
  final Color? uncheckColor;
  final Color? indeterminateCheckColor;
  final MainAxisSize mainAxisSize;

  ZCheckBox(
    this.data, {
    this.value = false,
    this.tag,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.alignment,
    this.onChanged,
    this.checkedStyle,
    this.checkedDecoration,
    this.uncheckedStyle,
    this.uncheckedDecoration,
    this.noBox = false,
    this.tristate = false,
    this.checkIcon,
    this.uncheckIcon,
    this.indeterminateCheckIcon,
    this.drawablePadding,
    this.checkColor,
    this.uncheckColor,
    this.indeterminateCheckColor,
    this.mainAxisSize = MainAxisSize.min,
  }) : assert(!noBox || !tristate || (noBox == true && tristate != true), '没有选中框，三态无法UI展示');

  @override
  _ZCheckBoxState createState() => _ZCheckBoxState();
}

class _ZCheckBoxState extends State<ZCheckBox> {
  bool? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    var child;
    child = Text(
      widget.data,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: widget.value == false ? widget.uncheckedStyle : widget.checkedStyle,
    );
    if (widget.noBox != true) {
      var box;
      if (_value == true) {
        box = widget.checkIcon ?? Icon(Icons.check_box, color: widget.checkColor);
      } else if (widget.tristate == true && _value == null) {
        box = widget.indeterminateCheckIcon ?? Icon(Icons.indeterminate_check_box, color: widget.indeterminateCheckColor);
      } else {
        box = widget.uncheckIcon ?? Icon(Icons.check_box_outline_blank, color: widget.uncheckColor);
      }
      child = Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: widget.mainAxisSize,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          box,
          SizedBox(width: widget.drawablePadding ?? 10.toFit),
          child,
        ],
      );
    }
    child = Container(
      width: widget.width,
      height: widget.height,
      padding: widget.padding,
      margin: widget.margin,
      decoration: widget.value == true ? widget.checkedDecoration : widget.uncheckedDecoration,
      alignment: widget.alignment,
      child: child,
    );
    return InkWell(
      onTap: () {
        setState(() {
          if (widget.tristate == true) {
            _value = (_value == true) ? null : (_value == null ? false : true);
          } else {
            _value = !_value!;
          }
          widget.onChanged!(_value);
        });
      },
      child: child,
    );
  }
}
