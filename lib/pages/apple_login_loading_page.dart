import 'package:englishindustry/utility/future.dart';
import 'package:englishindustry/utility/theme_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppleLoginLoading extends StatefulWidget { 
  final String user;
  final String name;
  final String email;

  const AppleLoginLoading({Key key, @required this.user,@required this.email,@required this.name}) : super(key: key);

  @override
  State<AppleLoginLoading> createState() => _AppleLoginLoadingState();
}

class _AppleLoginLoadingState extends State<AppleLoginLoading> {
  @override
  void initState() {    
    AppFuture.signInWthEmail(context, widget.user).then((value) {
    if(  widget.name!=null && widget.name!=""){ AppFuture.updateUserName(widget.name).then(
            (value) {
          if (value) {
            // AppFuture.customToast(
            //     AppLocalizations.of(context).translate("saved"));
            AppFuture.getDataForUserHome(context, 3);
          }
        },);}
      AppFuture.getDataForUserHome(context, 0);
      if (kDebugMode) {
        print('nammmmmmmme ${widget.name}');
      }

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ThemeStyles.offWhite,
      body: Center(
        child: CircularProgressIndicator(
          color: ThemeStyles.red,
          backgroundColor: ThemeStyles.white,
        ),
      ),
    );
  }
}
