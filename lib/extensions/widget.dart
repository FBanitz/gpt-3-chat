import 'package:flutter/material.dart';

extension WidgetPadding on Widget {
  Widget widgetPadding([EdgeInsets padding = const EdgeInsets.all(16)]) => Padding(
    padding: padding,
    child: this,
  );
}

extension WidgetCornerRadius on Widget {
  Widget widgetCornerRadius([BorderRadiusGeometry radius = const BorderRadius.all(Radius.circular(16))]) => ClipRRect(
    borderRadius: radius,
    child: this,
  );
}

extension WidgetBorder on Widget {
  Widget widgetBorder(Border border) => Container(
    decoration: BoxDecoration(
      border: border,
    ),
    child: this,
  );
}

extension WidgetShadow on Widget {
  Widget widgetShadow([List<BoxShadow> shadows = const [
    BoxShadow(
      color: Colors.black26,
      blurRadius: 10,
      offset: Offset(0, 5),
    ),
  ]]) => Container(
    decoration: BoxDecoration(
      boxShadow: shadows,
    ),
    child: this,
  );
}

extension WidgetBackground on Widget {
  Widget widgetBackground(Color color) => DecoratedBox(
    decoration: BoxDecoration(
      color: color,
    ),
    child: this,
  );
}
