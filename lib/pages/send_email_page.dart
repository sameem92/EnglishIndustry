import 'package:englishindustry/utility/double_shadow_container.dart';
import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/utility/app_localizations.dart';
import 'package:englishindustry/utility/future.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class SendEmail extends StatefulWidget {
  final String appEmail, userEmail;
  const SendEmail({Key key, @required this.appEmail, @required this.userEmail})
      : super(key: key);

  @override
  State<SendEmail> createState() => _SendEmailState();
}

class _SendEmailState extends State<SendEmail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userEmail, subject, message;
  void validateAndSave(BuildContext context) {
    final FormState form = _formKey.currentState;
    _formKey.currentState.save();
    if (form.validate()) {
      AppFuture.checkConnection(context).then((value) {
        if (value) {
          sendEmail(context);
        } else {
          AppFuture.customToast(
              AppLocalizations.of(context).translate("checkInternet"));
        }
      });
    } else {}
  }

  Future sendEmail(BuildContext context) async {
    final Email email = Email(
      body: message,
      subject: subject,

      recipients: [widget.appEmail],
      isHTML: false,
    );
    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = AppLocalizations.of(context).translate("sent");
    } catch (error) {
      platformResponse = error.toString();
      if (kDebugMode) {
        print(error.toString());
      }
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeStyles.offWhite,
        toolbarHeight: ThemeStyles.setHeight(60),
        centerTitle: true,
        elevation: 0.0,
        leadingWidth: ThemeStyles.setWidth(80),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ThemeStyles.red,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          AppLocalizations.of(context).translate("sendMail"),
          style: ThemeStyles.regularStyle().copyWith(
              color: ThemeStyles.red, fontSize: ThemeStyles.setWidth(18)),
        ),
      ),
      backgroundColor: ThemeStyles.offWhite,
      body: SizedBox(
        width: ThemeStyles.setFullWidth(),
        height: ThemeStyles.setFullHeight(),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // BackPressHeader(
                    //   title: AppLocalizations.of(context).translate("sendMail"),
                    // ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ThemeStyles.setWidth(30),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(children: [
                          ThemeStyles.space(),
                          ThemeStyles.halfSpace(),
                          TextFormField(
                            enabled: false,
                            readOnly: true,
                            initialValue: widget.appEmail,
                            style: ThemeStyles.regularStyle().copyWith(
                              color: ThemeStyles.red,
                            ),
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                hintText: widget.appEmail,prefixIcon: const Icon(Icons.email_outlined),
                                hintStyle: ThemeStyles.regularStyle().copyWith(
                                  color: ThemeStyles.lightRed,

                                  fontSize: ThemeStyles.setWidth(12),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      ThemeStyles.setWidth(15)),
                                  borderSide: const BorderSide(
                                      color: ThemeStyles.lightGrey, width: .5),
                                ),
                                contentPadding:
                                    EdgeInsets.all(ThemeStyles.setWidth(10)),
                                filled: true,
                                fillColor: ThemeStyles.white.withOpacity(0.5)),
                          ),
                          ThemeStyles.halfSpace(),
                          TextFormField(
                            cursorColor: ThemeStyles.red,
                            style: ThemeStyles.regularStyle().copyWith(
                              color: ThemeStyles.red,
                            ),
                            textAlignVertical: TextAlignVertical.center,
                            validator: (value) {
                              return value.isEmpty
                                  ? "Please Add email Subject"
                                  : null;
                            },
                            onSaved: (value) {
                              setState(() {
                                subject = value;
                              });
                            },
                            textInputAction: TextInputAction.next,
                            textAlign: TextAlign.start,
                            obscureText: false,
                            decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)
                                    .translate("subject"),
                                hintStyle: ThemeStyles.regularStyle().copyWith(
                                  color: ThemeStyles.red,
                                  fontSize: ThemeStyles.setWidth(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: ThemeStyles.lightGrey,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      ThemeStyles.setWidth(15)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: ThemeStyles.red, width: .5),
                                  borderRadius: BorderRadius.circular(
                                      ThemeStyles.setWidth(15)),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      ThemeStyles.setWidth(15)),
                                  borderSide: const BorderSide(
                                      color: ThemeStyles.lightGrey, width: .5),
                                ),
                                contentPadding:
                                    EdgeInsets.all(ThemeStyles.setWidth(10)),
                                filled: true,
                                fillColor: ThemeStyles.white.withOpacity(0.5)),
                          ),
                          ThemeStyles.halfSpace(),
                          TextFormField(
                            cursorColor: ThemeStyles.red,
                            maxLines: 15,
                            style: ThemeStyles.regularStyle().copyWith(
                              color: ThemeStyles.red,
                            ),
                            textAlignVertical: TextAlignVertical.center,
                            validator: (value) {
                              return value.isEmpty
                                  ? "please Enter Your Message"
                                  : null;
                            },
                            onSaved: (value) {
                              setState(() {
                                message = value;
                              });
                            },
                            textInputAction: TextInputAction.next,
                            textAlign: TextAlign.start,
                            obscureText: false,
                            decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)
                                    .translate("message"),
                                hintStyle: ThemeStyles.regularStyle().copyWith(
                                  color: ThemeStyles.red,
                                  fontSize: ThemeStyles.setWidth(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: ThemeStyles.lightGrey,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      ThemeStyles.setWidth(15)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: ThemeStyles.red, width: .5),
                                  borderRadius: BorderRadius.circular(
                                      ThemeStyles.setWidth(15)),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      ThemeStyles.setWidth(15)),
                                  borderSide: const BorderSide(
                                      color: ThemeStyles.lightGrey, width: .5),
                                ),
                                contentPadding:
                                    EdgeInsets.all(ThemeStyles.setWidth(10)),
                                filled: true,
                                fillColor: ThemeStyles.white.withOpacity(0.5)),
                          ),
                          ThemeStyles.space(),
                          ThemeStyles.space(),
                          InkWell(
                            onTap: () {
                              validateAndSave(context);
                            },
                            child: DoubleShadowContainer(
                              width: ThemeStyles.setWidth(200),
                              height: ThemeStyles.setWidth(60),
                              padding: 12,
                              shadWidth: 5,
                              shadOpacity: 0,
                              borderRadius: ThemeStyles.setWidth(120),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate("submit"),
                                  style: ThemeStyles.boldStyle().copyWith(
                                    color: ThemeStyles.red,
                                    fontSize: ThemeStyles.setWidth(14),
                                  ),
                                ),
                              ),
                              borderColor: ThemeStyles.white.withOpacity(0.0),
                            ),
                          )
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
