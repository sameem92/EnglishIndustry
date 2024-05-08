import 'package:englishindustry/utility/double_shadow_container.dart';
import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/utility/app_localizations.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: ThemeStyles.setFullHeight() * 1.15,
        ),
        Positioned(
          left: -ThemeStyles.setFullWidth() * 0.55,
          top: -ThemeStyles.setFullWidth() * 0.2,
          child: DoubleShadowContainer(
            width: ThemeStyles.setFullWidth() * 0.8,
            height: ThemeStyles.setFullWidth() * 0.8,
            padding: 0,
            shadWidth: 100,
            shadOpacity: 0.15,
            borderRadius: ThemeStyles.setFullWidth() * 0.65,
            child: null,
            borderColor: ThemeStyles.white.withOpacity(0.5),
          ),
        ),
        Positioned(
          left: ThemeStyles.setFullWidth() * 0.32,
          top: ThemeStyles.setFullWidth() * 0.15,
          child: FittedBox(
            child: Row(
              children: [
                DoubleShadowContainer(
                  width: ThemeStyles.setWidth(100),
                  height: ThemeStyles.setWidth(100),
                  padding: 18,
                  shadWidth: 15,
                  shadOpacity: 0.3,
                  borderRadius: ThemeStyles.setWidth(120),
                  child: Image.asset("assets/images/logo.png"),
                  borderColor: ThemeStyles.white.withOpacity(0.5),
                ),
                ThemeStyles.hSpace(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)
                          .translate("english")
                          .toUpperCase(),
                      style: ThemeStyles.boldStyle().copyWith(
                        color: ThemeStyles.red,
                        fontSize: ThemeStyles.setWidth(20),
                        //letterSpacing: 3.0,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)
                          .translate("indust")
                          .toUpperCase(),
                      style: ThemeStyles.regularStyle().copyWith(
                        color: ThemeStyles.red,
                        fontSize: ThemeStyles.setWidth(20),

                        //letterSpacing: 1.1,
                      ),
                    ),
                    ThemeStyles.quartSpace(),
                    Text(
                      AppLocalizations.of(context).translate("grow"),
                      style: ThemeStyles.regularStyle().copyWith(
                        //letterSpacing: -0.3,
                        color: ThemeStyles.black,
                        fontSize: ThemeStyles.setWidth(10),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
