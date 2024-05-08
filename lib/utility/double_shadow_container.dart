import 'package:englishindustry/utility/theme_styles.dart';
import 'package:flutter/material.dart';

class DoubleShadowContainer extends StatelessWidget {
  final double width, height, shadOpacity, borderRadius;
  final int padding, shadWidth;
  final Widget child;
  final Color borderColor;

  const DoubleShadowContainer({
    Key key,
    @required this.width,
    @required this.height,
    @required this.shadOpacity,
    @required this.borderRadius,
    @required this.padding,
    @required this.shadWidth,
    @required this.child,
    @required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ThemeStyles.setWidth(padding)),
      width: width,
      height: height,
      decoration: ThemeStyles.doubleShadowDecoration(
              shadWidth, shadOpacity, borderRadius)
          .copyWith(
              border: Border.all(color: borderColor),
              color: ThemeStyles.offWhite),
      child: child,
    );
  }
}
