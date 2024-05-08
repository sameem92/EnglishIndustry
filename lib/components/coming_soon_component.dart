import 'package:englishindustry/utility/theme_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrainningPrograms extends StatelessWidget {
  final String title, content;
  final Color bgColor;
  const TrainningPrograms({
    Key key,
    @required this.title,
    @required this.bgColor,
    @required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: ThemeStyles.setWidth(20)),
          color: bgColor,
          height: ThemeStyles.setHeight(550),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ThemeStyles.space(),
                Text(
                  title,
                  style: ThemeStyles.boldStyle().copyWith(
                    color: ThemeStyles.red,
                    fontSize: ThemeStyles.setWidth(22),
                  ),
                ),
                // ThemeStyles.space(),
                SvgPicture.asset("assets/images/coming_soon.svg"),
                // ThemeStyles.space(),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: ThemeStyles.setWidth(20),
                  ),
                  child: Text(
                    content,
                    textAlign: TextAlign.center,
                    style: ThemeStyles.regularStyle().copyWith(
                        color: ThemeStyles.red,
                        fontSize: ThemeStyles.setWidth(15)),
                  ),
                ),
                ThemeStyles.space(),
              ]),
        ),
      ],
    );
  }
}
