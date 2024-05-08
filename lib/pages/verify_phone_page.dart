import 'package:englishindustry/headers/login_header.dart';
import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/utility/app_localizations.dart';
import 'package:englishindustry/utility/future.dart';
import 'package:englishindustry/components/verify_phone_component.dart';
import 'package:flutter/material.dart';

class VerifyPhone extends StatefulWidget {
  final String activeCode, phone;
  const VerifyPhone({Key key, @required this.activeCode, @required this.phone})
      : super(key: key);

  @override
  State<VerifyPhone> createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  bool isGoogleTapped, isVerifyTapped, canLeavePage;

  @override
  void initState() {
    canLeavePage = true;
    isVerifyTapped = false;
    isGoogleTapped = false;
    super.initState();
  }

  Future<bool> leavePage() async {
    if (canLeavePage) {
      AppFuture.customToast(AppLocalizations.of(context).translate("pressToExit"));
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
                  top: ThemeStyles.setFullWidth() * 0.65,
                  child: FittedBox(
                    child: SizedBox(
                      width: ThemeStyles.setWidth(285),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Verify(
                              activeCode: widget.activeCode,
                              phone: widget.phone),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
