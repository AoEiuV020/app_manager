import 'package:app_manager/model/app.dart';
import 'package:app_manager/controller/app_manager_controller.dart';
import 'package:app_manager/theme/app_colors.dart';
import 'package:app_manager/widgets/app_icon_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:global_repository/global_repository.dart';

import 'common_app_page.dart';
import 'long_press_dialog.dart';

class AlreadyInstall extends StatefulWidget {
  @override
  _AlreadyInstallState createState() => _AlreadyInstallState();
}

class _AlreadyInstallState extends State<AlreadyInstall>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: <Widget>[
                  CommonAppPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoundedUnderlineTabIndicator extends Decoration {
  const RoundedUnderlineTabIndicator({
    this.borderSide = const BorderSide(width: 2.0, color: Colors.white),
    this.insets = EdgeInsets.zero,
    this.radius,
    this.width,
  })  : assert(borderSide != null),
        assert(insets != null);
  final BorderSide borderSide;
  final EdgeInsetsGeometry insets;
  final double radius;
  final double width;

  @override
  Decoration lerpFrom(Decoration a, double t) {
    if (a is RoundedUnderlineTabIndicator) {
      return RoundedUnderlineTabIndicator(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t),
        radius: radius ?? borderSide.width * 5,
        width: width,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration lerpTo(Decoration b, double t) {
    if (b is RoundedUnderlineTabIndicator) {
      return RoundedUnderlineTabIndicator(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t),
        radius: radius ?? borderSide.width * 5,
        width: width,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  _RoundedUnderlinePainter createBoxPainter([VoidCallback onChanged]) {
    return _RoundedUnderlinePainter(
      this,
      onChanged,
      radius: radius ?? borderSide.width * 5,
      width: width,
    );
  }
}

class _RoundedUnderlinePainter extends BoxPainter {
  _RoundedUnderlinePainter(
    this.decoration,
    VoidCallback onChanged, {
    @required this.radius,
    this.width,
  })  : assert(decoration != null),
        super(onChanged);
  final double radius;
  final double width;

  final RoundedUnderlineTabIndicator decoration;

  BorderSide get borderSide => decoration.borderSide;
  EdgeInsetsGeometry get insets => decoration.insets;

  RRect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    assert(rect != null);
    assert(textDirection != null);
    final Rect indicator = insets.resolve(textDirection).deflateRect(rect);
    return RRect.fromRectAndCorners(
      width == null
          ? Rect.fromLTWH(
              indicator.left,
              indicator.bottom - borderSide.width,
              indicator.width,
              borderSide.width,
            )
          : Rect.fromCenter(
              center: Offset(
                indicator.left + indicator.width / 2,
                indicator.bottom - borderSide.width,
              ),
              width: width,
              height: borderSide.width,
            ),
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
    );
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size;
    final TextDirection textDirection = configuration.textDirection;
    final RRect indicator =
        _indicatorRectFor(rect, textDirection).deflate(borderSide.width);
    final Paint paint = borderSide.toPaint()
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.fill;
    // Paint _paintFore = Paint()
    //   ..color = Colors.red
    //   ..strokeCap = StrokeCap.round
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 2
    //   ..isAntiAlias = true;
    canvas.drawRRect(indicator, paint);
  }
}
