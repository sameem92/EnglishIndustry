import 'package:englishindustry/utility/double_shadow_container.dart';
import 'package:englishindustry/headers/login_header.dart';
import 'package:englishindustry/components/email_sign_in_component.dart';
import 'package:englishindustry/components/phone_signin_component.dart';
import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/utility/app_localizations.dart';
import 'package:englishindustry/utility/constants.dart';
import 'package:englishindustry/utility/future.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isNextTapped;
  bool canLeavePage;

  @override
  void initState() {
    canLeavePage = true;
    isNextTapped = false;
    super.initState();
  }

  Future<bool> leavePage() async {
    if (canLeavePage) {
      AppFuture.customToast(
          AppLocalizations.of(context).translate("pressToExit"));
    }
    setState(() {
      canLeavePage = !canLeavePage;
    });
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        canLeavePage = true;
      });
    });
    return canLeavePage;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: leavePage,
      child: Scaffold(
        backgroundColor: ThemeStyles.offWhite,
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              const LoginHeader(),
              Positioned(
                left: -ThemeStyles.setFullWidth() * 0.85,
                bottom: ThemeStyles.setFullWidth() * 0.2,
                child: DoubleShadowContainer(
                  width: ThemeStyles.setFullWidth(),
                  height: ThemeStyles.setFullWidth(),
                  padding: 0,
                  shadWidth: 150,
                  shadOpacity: 0.1,
                  borderRadius: ThemeStyles.setFullWidth() * 0.65,
                  child: null,
                  borderColor: ThemeStyles.white.withOpacity(0.2),
                ),
              ),
              Positioned(
                top: AppConstants.langCode == "en"
                    ? ThemeStyles.setFullWidth() * 0.57
                    : ThemeStyles.setFullWidth() * 0.52,
                child: FittedBox(
                  child: SizedBox(
                    width: ThemeStyles.setWidth(285),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        PhoneSignIn(),
                        EmailSignInComp(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
