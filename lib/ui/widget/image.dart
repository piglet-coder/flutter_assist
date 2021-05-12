import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assist/flutter_assist.dart';

/// @author zdl
/// date 2020/11/16 15:36
/// email zdl328465042@163.com
/// description 图片控件
class ZImage extends StatefulWidget {
  final String src;
  final double width;
  final double height;
  final Color color;
  final BoxFit fit;
  final bool useCached;
  final double radius;
  final double aspectRatio;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final String imageFolder;

  const ZImage({
    @required this.src,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.cover,
    this.useCached,
    this.radius,
    this.aspectRatio,
    this.onTap,
    this.onLongPress,
    this.imageFolder,
  }) : assert(src != null);

  @override
  _ZImageState createState() => _ZImageState();
}

class _ZImageState extends State<ZImage> {
  bool _isDown = false;

  @override
  Widget build(BuildContext context) {
    var image;
    //加载
    if (widget.src.startsWith(widget.imageFolder ?? ZConfigImage.imageFolder)) {
      //资源文件图片
      image = Image.asset(
        widget.src,
        width: widget.width,
        height: widget.height,
        color: widget.color,
        fit: widget.fit,
      );
    } else if (widget.src.startsWith('http')) {
      //网络图片
      if (widget.useCached ?? ZConfigImage.useCached) {
        image = CachedNetworkImage(
          imageUrl: widget.src,
          width: widget.width,
          height: widget.height,
          color: widget.color,
          fit: widget.fit,
        );
      } else {
        image = Image.network(
          widget.src,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
        );
      }
    } else {
      //本地文件图片
      image = Image.file(
        File(widget.src),
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
      );
    }
    //裁剪
    if (widget.radius != null && widget.radius > 0) {
      if (widget.radius == double.infinity) {
        image = ClipOval(child: image);
      } else {
        image = ClipRRect(
          borderRadius: BorderRadius.circular(widget.radius),
          child: image,
        );
      }
    }
    //固定宽高比
    if (widget.aspectRatio != null) {
      image = AspectRatio(
        aspectRatio: widget.aspectRatio,
        child: image,
      );
    }
    //点击事件
    if (widget.onTap != null || widget.onLongPress != null) {
      image = InkWell(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          foregroundDecoration: BoxDecoration(
            color: _isDown ? Colors.white.withOpacity(0.5) : Colors.transparent,
          ),
          child: image,
        ),
        onTapDown: (_) {
          setState(() {
            _isDown = true;
          });
        },
        onTapCancel: () {
          setState(() {
            _isDown = false;
          });
        },
        onHighlightChanged: (b) {
          setState(() {
            if (!b) _isDown = false;
          });
        },
      );
    }
    return image;
  }
}
