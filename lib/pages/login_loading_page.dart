import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/utility/future.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginLoading extends StatefulWidget {
  final GoogleSignInAccount user;
  const LoginLoading({Key key, @required this.user}) : super(key: key);

  @override
  State<LoginLoading> createState() => _LoginLoadingState();
}

class _LoginLoadingState extends State<LoginLoading> {
  @override
  void initState() {
    AppFuture.signInWthEmail(context, widget.user.email).then((value) {
      // AppFuture.updateUserImageData(widget.user.photoUrl,widget.user.displayName);
      // AppFuture.updateUserName(widget.user.displayName);
      if(  widget.user.displayName!=null && widget.user.displayName!=""){  AppFuture.updateUserName(widget.user.displayName).then(
              (value) {
            if (value) {
              // AppFuture.customToast(
              //     AppLocalizations.of(context).translate("saved"));
              AppFuture.getDataForUserHome(context, 3);
            }
          },);}


      if (kDebugMode) {
        print('imaaaaaaaaaaage ${widget.user.photoUrl}');
      }
      if (kDebugMode) {
        print('nammmmmmmme ${widget.user.displayName}');
      }
      AppFuture.getDataForUserHome(context, 0);
    });
// if(widget.user.photoUrl!=null ||widget.user.photoUrl!=''){
//     AppFuture.updateUserImageData(widget.user.photoUrl,widget.user.displayName).then((value) {
//       AppFuture.getDataForUserHome(context, 0);
//     });}else if(widget.user.displayName!=null ||widget.user.displayName!=''){
//   AppFuture.updateUserName(widget.user.displayName).then((value) {
//     AppFuture.getDataForUserHome(context, 0);
//   });


// }else{}



    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ThemeStyles.offWhite,
      body: Center(
        child: CircularProgressIndicator(
          color:Color(0xFFc3698a),
          backgroundColor: ThemeStyles.white,
        ),
      ),
    );
  }
}
