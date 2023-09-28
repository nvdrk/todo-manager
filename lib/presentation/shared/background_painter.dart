import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BackgroundPainter extends SingleChildRenderObjectWidget {
  const BackgroundPainter({
    super.key,
    this.color = const Color(0xff565d6e),
    this.padding = EdgeInsets.zero,
    super.child,
  });

  final Color color;

  final EdgeInsets padding;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderBackgroundPaint(color: color, padding: padding);
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderObject renderObject) {
    (renderObject as RenderBackgroundPaint)
      ..color = color
      ..padding = padding;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Color>('color', color));
  }
}

class RenderBackgroundPaint extends RenderProxyBoxWithHitTestBehavior {
  RenderBackgroundPaint({
    required Color color,
    required EdgeInsets padding,
  })  : _color = color,
        _padding = padding,
        super(behavior: HitTestBehavior.opaque);

  Color _color;
  Color get color => _color;
  set color(Color value) {
    if (value == _color) {
      return;
    }
    _color = value;
    markNeedsPaint();
  }

  EdgeInsets _padding;
  EdgeInsets get padding => _padding;
  set padding(EdgeInsets value) {
    if (_padding == value) return;
    _padding = value;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, ui.Offset offset) {
    if (size > Size.zero) {
      final canvas = context.canvas
        ..save()
        ..translate(offset.dx + padding.left, offset.dy + padding.top);

      _paintBackground(canvas);

      canvas.restore();
    }
    if (child != null) {
      context.paintChild(child!, offset);
    }
  }

  void _paintBackground(Canvas canvas) {
    final width = size.width;
    final height = size.height;

    final path0 = Path()
      ..moveTo(0, height * .8781)
      ..cubicTo(0, height * .8781, width * .1491, height * .8537, width * .2165,
          height * .831)
      ..cubicTo(width * .2839, height * .8084, width * .3976, height * .7433,
          width * .3976, height * .7433)
      ..cubicTo(width * .3976, height * .7433, width * .5886, height * .8235,
          width * .6717, height * .8393)
      ..cubicTo(width * .7548, height * .8552, width * .8179, height * .8527,
          width * 8730, height * .8504)
      ..cubicTo(width * .9281, height * .8481, width * .9982, height * .8329,
          width * .9982, height * .8329)
      ..lineTo(width, height)
      ..lineTo(0, height)
      ..close();

    final paint0 = Paint()
      ..style = PaintingStyle.fill
      ..color = color.withOpacity(.4);
    canvas.drawPath(path0, paint0);

    final path1 = Path()
      ..moveTo(0, height * .8735)
      ..lineTo(0, height * .8237)
      ..lineTo(width * .1590, height * .7932)
      ..lineTo(width * .7241, height)
      ..lineTo(0, height)
      ..close();

    final paint1 = Paint()
      ..style = PaintingStyle.fill
      ..color = color.withOpacity(0.5);
    canvas.drawPath(path1, paint1);

    final path2 = Path()
      ..moveTo(0, height * .8237)
      ..cubicTo(0, height * .8237, width * .0784, height * .7944, width * .0998,
          height * .7803)
      ..cubicTo(width * .1212, height * .7662, width * .1353, height * .7443,
          width * .1353, height * .7443)
      ..cubicTo(width * .1353, height * .7443, width * .3954, height * .6928,
          width * .4805, height * .6612)
      ..cubicTo(width * .5656, height * .6296, width * .6514, height * .5689,
          width * .6514, height * .5689)
      ..cubicTo(width * .6514, height * .5689, width * .8452, height * .5501,
          width * .9035, height * .5255)
      ..cubicTo(width * .9619, height * .5009, width * .9983, height * .4434,
          width, height * .4434)
      ..lineTo(width, height)
      ..lineTo(0, height)
      ..close();

    final paint2 = Paint()
      ..style = PaintingStyle.fill
      ..color = color.withOpacity(0.3);
    canvas.drawPath(path2, paint2);

    final path3 = Path()
      ..moveTo(width, height * .6833)
      ..cubicTo(width, height * .6833, width * .9662, height * .7105,
          width * .9035, height * .7157)
      ..cubicTo(width * .8408, height * .7208, width * .64467, height * .6797,
          width * .6446, height * .6797)
      ..lineTo(width * .2115, height)
      ..lineTo(width, height)
      ..lineTo(width, height * .6778);

    final paint3 = Paint()
      ..style = PaintingStyle.fill
      ..color = color.withOpacity(0.5);

    canvas.drawPath(path3, paint3);

  }
}
