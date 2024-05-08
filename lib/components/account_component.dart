import 'package:email_validator/email_validator.dart';
import 'package:englishindustry/utility/custom_dialogues.dart';
import 'package:englishindustry/data/data_api_service.dart';
import 'package:englishindustry/pages/faq_page.dart';
import 'package:englishindustry/pages/myfavourite_page.dart';
import 'package:englishindustry/pages/send_email_page.dart';
import 'package:englishindustry/pages/splash_page.dart';
import 'package:englishindustry/pages/terms_page.dart';
import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/utility/app_localizations.dart';
import 'package:englishindustry/utility/future.dart';
import 'package:englishindustry/utility/google_signin_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io' show File, Platform;

class Account extends StatefulWidget {
  final Map<String, dynamic> data;

  const Account({Key key, @required this.data}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();








  SharedPreferences prefs;

  bool canTab;
  String userName;
  File userImage;
  final picker = ImagePicker();
  bool isOpened;
  Map<String, dynamic> data;

  Future getSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    isOpened = false;
    data = widget.data;
    canTab = true;
    userName = data['personal_informations']['name'];
    getSharedPrefs();
    super.initState();
  }

  Future getImage() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          userImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      AppFuture.customToast("Please Allow Our App to Choose Your Image");
    }
  }

  void validateAndSave(BuildContext context) {
    final FormState form = _formKey.currentState;
    _formKey.currentState.save();

    if (form.validate()) {
      AppFuture.checkConnection(context).then(
        (value) {
          if (value) {
            if (userImage != null) {
              AppFuture.updateUserImageData(userImage.path, userName).then(
                (value) {
                  if (value) {
                    AppFuture.customToast(
                        AppLocalizations.of(context).translate("saved"));
                    AppFuture.getDataForUserHome(context, 3);
                  }
                },
              );
            } else {
              AppFuture.updateUserName(userName).then(
                (value) {
                  if (value) {
                    AppFuture.customToast(
                        AppLocalizations.of(context).translate("saved"));
                    AppFuture.getDataForUserHome(context, 3);
                  }
                },
              );
            }
          } else {
            AppFuture.customToast(
                AppLocalizations.of(context).translate("checkInternet"));
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(
                ThemeStyles.setWidth(25),
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isOpened = !isOpened;
                      });
                    },
                    child: Container(
                      width: ThemeStyles.setFullWidth(),
                      padding: EdgeInsets.symmetric(
                        horizontal: ThemeStyles.setWidth(15),
                        vertical: ThemeStyles.setWidth(8),
                      ),
                      decoration: BoxDecoration(
                        color: ThemeStyles.red,
                        borderRadius: BorderRadius.circular(
                          ThemeStyles.setWidth(30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ThemeStyles.hSpace(),
                          Text(
                            AppLocalizations.of(context).translate("settings"),
                            style: ThemeStyles.regularStyle()
                                .copyWith(color: ThemeStyles.white),
                          ),
                          Container(
                            padding: EdgeInsets.all(ThemeStyles.setWidth(7)),
                            width: ThemeStyles.setWidth(25),
                            height: ThemeStyles.setWidth(25),
                            decoration: BoxDecoration(
                              color: ThemeStyles.white,
                              borderRadius: BorderRadius.circular(
                                ThemeStyles.setWidth(30),
                              ),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/images/down_arrow.svg",
                                color: ThemeStyles.red,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  isOpened
                      ? Container(
                          width: ThemeStyles.setFullWidth(),
                          margin: EdgeInsets.symmetric(
                            horizontal: ThemeStyles.setWidth(20),
                            vertical: ThemeStyles.setWidth(15),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/images/account_circle_icon.svg",
                                        color: ThemeStyles.greyred,
                                        height: ThemeStyles.setHeight(40),
                                      ),
                                      ThemeStyles.hSpace(),
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate("pInfo"),
                                        style: ThemeStyles.boldStyle().copyWith(
                                          color: ThemeStyles.greyred,
                                          fontSize: ThemeStyles.setWidth(
                                            13,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      validateAndSave(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .translate("save"),
                                        style:
                                            ThemeStyles.regularStyle().copyWith(
                                          color: ThemeStyles.greyred,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              // ThemeStyles.halfSpace(),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: ThemeStyles.setWidth(30),
                                  vertical: ThemeStyles.setWidth(15),
                                ),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)
                                                    .translate("photo") + " :",
                                            style: ThemeStyles.boldStyle()
                                                .copyWith(
                                              color: ThemeStyles.greyred,
                                              fontSize: ThemeStyles.setWidth(
                                                12,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              getImage();
                                            },
                                            child: Column(
                                              children: [
                                                userImage != null
                                                    ? circleImg(
                                                        FileImage(userImage))
                                                    : data["personal_informations"]
                                                                ["image"] !=
                                                            null
                                                        ? circleImg(
                                                            NetworkImage(
                                                            DataApiService
                                                                    .imagebaseUrl +
                                                                data["personal_informations"]
                                                                    ["image"],
                                                          ))
                                                        : SvgPicture.asset(
                                                            "assets/images/account_circle_icon.svg",
                                                            width: ThemeStyles
                                                                .setWidth(80),
                                                          ),
                                              ],
                                            ),
                                          ),
                                          ThemeStyles.hSpace(),
                                        ],
                                      ),
                                      ThemeStyles.halfSpace(),
                                      ThemeStyles.halfSpace(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate("username")+ " :",
                                            style: ThemeStyles.boldStyle()
                                                .copyWith(
                                              color: ThemeStyles.greyred,
                                              fontSize: ThemeStyles.setWidth(
                                                12,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),

                                          Expanded(
                                              child:
                                              SizedBox(
                                                height: 40,

                                                child: TextFormField(
                                                  cursorColor: ThemeStyles.red,
                                            initialValue:
                                                  data["personal_informations"]
                                                      ["name"],
                                            style: ThemeStyles.regularStyle()
                                                  .copyWith(
                                                color: ThemeStyles.red,
                                            ),
                                            textAlignVertical:
                                                  TextAlignVertical.center,

                                            // validator: (value) {
                                            //     return value.isEmpty
                                            //         ? "please add name"
                                            //         : null;
                                            // },
                                            onSaved: (value) {
                                                setState(() {
                                                  userName = value;
                                                });
                                            },
                                            textInputAction:
                                                  TextInputAction.next,
                                            textAlign: TextAlign.center,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                                hintText: "username",
                                                hintStyle:
                                                    ThemeStyles.regularStyle()
                                                        .copyWith(
                                                  color: ThemeStyles.lightRed,
                                                  fontSize:
                                                      ThemeStyles.setWidth(11),
                                                ),
                                                enabledBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: ThemeStyles.offWhite,
                                                      width: 0.0),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: ThemeStyles.red,
                                                      width: .5),
                                                  borderRadius:
                                                      BorderRadius.circular(25.0),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          ThemeStyles.setWidth(
                                                              5)),
                                                  borderSide: const BorderSide(
                                                      color: ThemeStyles.offWhite,
                                                      width: 0.0),
                                                ),
                                                contentPadding: EdgeInsets.all(
                                                    ThemeStyles.setWidth(0)),
                                                filled: false,
                                            ),
                                          ),
                                              )),
                                        ],
                                      ),
                                      ThemeStyles.halfSpace(),
                                      data["personal_informations"]
                                      ["email"]!=null &&data["personal_informations"]
                                      ["email"].toString().contains('@')?

                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(

                                            child: Text(
                                              AppLocalizations.of(context)
                                                  .translate("email")+ " :",
                                              // maxLines: 2,
                                              maxLines: 1,
                                              style: ThemeStyles.boldStyle()
                                                  .copyWith(
                                                color: ThemeStyles.greyred,
                                                fontSize: ThemeStyles.setWidth(
                                                  12,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Text(
                                              data["personal_informations"]
                                              ["email"],
                                              // maxLines: 2,
                                              // softWrap: true,
                                              // overflow: TextOverflow.clip,
                                              style: ThemeStyles.boldStyle()
                                                  .copyWith(
                                                color: ThemeStyles.greyred,
                                                fontSize: ThemeStyles.setWidth(
                                                  12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ):Column(),

                                      ThemeStyles.halfSpace(),
                                      data["personal_informations"]
                                      ["phone"]!=null?Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate("phone")+ " :",
                                            style: ThemeStyles.boldStyle()
                                                .copyWith(
                                              color: ThemeStyles.greyred,
                                              fontSize: ThemeStyles.setWidth(
                                                12,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            data["personal_informations"]
                                            ["phone"],
                                            maxLines: 2,
                                            softWrap: true,
                                            overflow: TextOverflow.clip,
                                            style: ThemeStyles.boldStyle()
                                                .copyWith(
                                              color: ThemeStyles.greyred,
                                              fontSize: ThemeStyles.setWidth(
                                                12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ):Column(),
                                      ThemeStyles.space(),
                                      ThemeStyles.space(),

                                      InkWell(
                                        onTap: () {
                                          AppFuture.checkConnection(context)
                                              .then((value) {
                                            if (value) {
                                              AppFuture.getTerms(context)
                                                  .then((uterms) {
                                                if (uterms != null) {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Terms(
                                                        data: uterms,
                                                      ),
                                                    ),
                                                  );
                                                }
                                              });
                                            } else {
                                              AppFuture.customToast(
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          "checkInternet"));
                                            }
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              "assets/images/terms_icon.svg",
                                              color: ThemeStyles.greyred,
                                              height: ThemeStyles.setHeight(25),
                                            ),
                                            ThemeStyles.hSpace(),
                                            Text(
                                              AppLocalizations.of(context)
                                                  .translate("termCondition"),
                                              style: ThemeStyles.boldStyle()
                                                  .copyWith(
                                                color: ThemeStyles.greyred,
                                                fontSize: ThemeStyles.setWidth(
                                                  12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // ThemeStyles.space(),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : ThemeStyles.halfSpace(),
                  ThemeStyles.halfSpace(),
                  InkWell(
                    child: socialContainer(
                      const Icon(
                        Icons.credit_card,
                        color: ThemeStyles.white,
                      ),
                      AppLocalizations.of(context).translate("subsPlan"),
                    ),
                  ),
                  ThemeStyles.halfSpace(),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: ThemeStyles.setWidth(20),
                      vertical: ThemeStyles.setHeight(15),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/credit_icon.svg",
                                  height: ThemeStyles.setHeight(30),
                                ),
                                ThemeStyles.hSpace(),
                                Text(
                                  AppLocalizations.of(context)
                                      .translate("myPlan"),
                                  style: ThemeStyles.boldStyle().copyWith(
                                    color: ThemeStyles.greyred,
                                    fontSize: ThemeStyles.setWidth(
                                      13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                 data['personal_informations']
                                ['subscription_plan'] ==
                                    0? Column()
                                :
                                 const Icon(
                                   Icons.check_circle,
                                   color: ThemeStyles.green,
                                 )
                                ,
                                ThemeStyles.hSmSpace(),
                                Text(
                                  data['personal_informations']
                                              ['subscription_plan'] ==
                                          0
                                      ? AppLocalizations.of(context)
                                          .translate("freePlan")
                                      : data['personal_informations']
                                                  ['subscription_plan'] ==
                                              1
                                          ? data['subscription_plans'][0]
                                              ["title"]
                                          : data['subscription_plans'][1]
                                              ["title"],
                                  style: ThemeStyles.boldStyle().copyWith(
                                    color:data['personal_informations']
                                    ['subscription_plan'] ==
                                        0?ThemeStyles.grey :ThemeStyles.green,
                                    fontSize: ThemeStyles.setWidth(
                                      12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        ThemeStyles.space(),
                        InkWell(
                          onTap: () {

                            if (data['personal_informations']
                                    ['subscription_plan'] ==1 || data['personal_informations']
                            ['subscription_plan'] ==2
                                ) {
                              AppFuture.customToast(
                                  AppLocalizations.of(context).translate("alreadySubscribe"));
                            }else {
                              CustomDialogues.showSubscriptionDialog(
                                context,
                                data['subscription_plans'][0]["price"],
                                data['subscription_plans'][1]["price"],
                                data['subscription_plans'][0]["id"].toString(),
                                data['subscription_plans'][1]["id"].toString(),
                                data['personal_informations']["name"] ??
                                    "user name",
                                data['personal_informations']["email"] !=
                                            null &&
                                        EmailValidator.validate(
                                            data['personal_informations']
                                                ["email"])
                                    ? data['personal_informations']["email"]
                                    : "test@gmail.com",
                                data['personal_informations']
                                    ['subscription_plan'],
                                data['subscription_plans'][0]["title"],
                                data['subscription_plans'][1]["title"],
                              );
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: ThemeStyles.setWidth(25),
                              vertical: ThemeStyles.setWidth(10),
                            ),
                            decoration: BoxDecoration(
                              color: data['personal_informations']
                              ['subscription_plan'] ==1 || data['personal_informations']
                              ['subscription_plan'] ==2
                                  ? ThemeStyles.grey
                                  : ThemeStyles.green,
                              borderRadius: BorderRadius.circular(
                                ThemeStyles.setWidth(30),
                              ),
                            ),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate("changePlan"),
                              style: ThemeStyles.boldStyle().copyWith(
                                color: ThemeStyles.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ThemeStyles.space(),
                  InkWell(
                    onTap: () {
                      AppFuture.checkConnection(context).then((value) {
                        if (value) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const MyFavourites(),
                            ),
                          );
                        } else {
                          AppFuture.customToast(AppLocalizations.of(context)
                              .translate("checkInternet"));
                        }
                      });
                    },
                    child: socialContainer(
                      const Icon(
                        Icons.favorite_border_outlined,
                        color: ThemeStyles.white,
                      ),
                      AppLocalizations.of(context).translate("favVideos"),
                    ),
                  ),
                  ThemeStyles.space(),
                  InkWell(
                    onTap: () {
                      AppFuture.checkConnection(context).then((value) {
                        if (value) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const FAQs(),
                            ),
                          );
                        } else {
                          AppFuture.customToast(AppLocalizations.of(context)
                              .translate("checkInternet"));
                        }
                      });
                    },
                    child: socialContainer(
                      SvgPicture.asset("assets/images/info_icon.svg"),
                      AppLocalizations.of(context).translate("faq"),
                    ),
                  ),
                  ThemeStyles.space(),
                  InkWell(
                    onTap: () {
                      onShare(context);
                    },
                    child: socialContainer(
                      SvgPicture.asset("assets/images/link_icon.svg"),
                      AppLocalizations.of(context).translate("shareApp"),
                    ),
                  ),
                  ThemeStyles.space(),
                  InkWell(
                    onTap: () {
                      if (Platform.isAndroid) {
                        launchURL(data["settings"]["googleplay"]);
                      } else if (Platform.isIOS) {
                        launchURL(data["settings"]["applestore"]);
                      }
                    },
                    child: socialContainer(
                      SvgPicture.asset("assets/images/rate_circle_icon.svg"),
                      AppLocalizations.of(context).translate("rateApp"),
                    ),
                  ),
                  ThemeStyles.space(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SendEmail(
                            userEmail: data["personal_informations"]["email"],
                            appEmail: data["settings"]["email"],
                          ),
                        ),
                      );
                    },
                    child: socialContainer(
                        SvgPicture.asset("assets/images/google_icon1.svg"),
                        AppLocalizations.of(context).translate("messageUs")),
                  ),
                  // ThemeStyles.space(),
                  ThemeStyles.space(),
                  InkWell(
                    onTap: () {
                      canTab = false;
                      AppFuture.checkConnection(context).then(
                        (value) {
                          if (value) {
                            logOutAccount();
                          } else {
                            canTab = true;
                            AppFuture.customToast(AppLocalizations.of(context)
                                .translate("checkInternet"));
                          }
                        },
                      );
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ThemeStyles.setWidth(25),
                        vertical: ThemeStyles.setWidth(10),
                      ),
                      decoration: BoxDecoration(
                        color: ThemeStyles.darkred,
                        borderRadius: BorderRadius.circular(
                          ThemeStyles.setWidth(30),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context).translate("logout"),
                        style: ThemeStyles.boldStyle().copyWith(
                          color: ThemeStyles.white,
                        ),
                      ),
                    ),
                  ),
                  ThemeStyles.space(),
                  InkWell(
                    onTap: () {
                      AppFuture.checkConnection(context).then(
                        (value) {
                          if (value) {
                            deletaAccountDialogue(context);
                          } else {
                            AppFuture.customToast(AppLocalizations.of(context)
                                .translate("checkInternet"));
                          }
                        },
                      );
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ThemeStyles.setWidth(25),
                        vertical: ThemeStyles.setWidth(10),
                      ),
                      decoration: BoxDecoration(
                        color: ThemeStyles.darkred,
                        borderRadius: BorderRadius.circular(
                          ThemeStyles.setWidth(30),
                        ),
                      ),
                      child: Text(
    AppLocalizations.of(context).translate("deleteAccount"),
                        style: ThemeStyles.boldStyle().copyWith(
                          color: ThemeStyles.white,
                        ),
                      ),
                    ),
                  ),
                  ThemeStyles.space(),
                  ThemeStyles.space(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void logOutAccount() {
    AppFuture.logout(context).then(
      (value) {
        if (value) {
          signOut();
          navigateToMain();
        }
      },
    );
  }

  Future<void> navigateToMain() async {
    prefs.clear();
    await const FlutterSecureStorage().deleteAll();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const MainProvider()),
      (route) => false,
    );
  }

  Future<bool> signOut() async {
    GoogleSignInApi.logout();
    // await FirebaseAuth.instance.signOut();
    return true;
  }

  Container circleImg(ImageProvider img) {
    return Container(
      width: 90.0,
      height: 90.0,
      // width: ThemeStyles.setWidth(80),
      // height: ThemeStyles.setHeight(80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ThemeStyles.setWidth(50)),
        image: DecorationImage(image: img, fit: BoxFit.cover),
      ),
    );
  }

  launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not Open $url';
    }
  }

  void onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox;
    if (Platform.isAndroid) {
      await Share.share(data["settings"]["googleplay"],
          subject: "English Industry",
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    } else if (Platform.isIOS) {
      await Share.share(data["settings"]["applestore"],
          subject: "English Industry",
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }
  }

  Container socialContainer(Widget icon, String title) {
    return Container(
      width: ThemeStyles.setFullWidth(),
      padding: EdgeInsets.symmetric(
        horizontal: ThemeStyles.setWidth(15),
        vertical: ThemeStyles.setWidth(8),
      ),
      decoration: BoxDecoration(
        color: ThemeStyles.red,
        borderRadius: BorderRadius.circular(
          ThemeStyles.setWidth(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: icon,
          ),
          ThemeStyles.hSpace(),
          Text(
            title,
            style:
                ThemeStyles.regularStyle().copyWith(color: ThemeStyles.white),
          ),
        ],
      ),
    );
  }

  void deletaAccountDialogue(
    BuildContext context,
  ) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,

      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      context: context,
      pageBuilder: (_, __, ___) {
        return StatefulBuilder(builder: (BuildContext newContext, setState) {
          return Material(
            type: MaterialType.transparency,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: ThemeStyles.setWidth(300),
                  height: ThemeStyles.setHeight(250),
                  decoration: BoxDecoration(
                      color: ThemeStyles.offWhite,
                      borderRadius: BorderRadius.all(
                        Radius.circular(ThemeStyles.setWidth(10)),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Container(
                      //   width: ThemeStyles.setWidth(80),
                      //   height: ThemeStyles.setHeight(5),
                      //   margin: EdgeInsets.only(top: ThemeStyles.setHeight(25)),
                      //   decoration: BoxDecoration(
                      //       color: ThemeStyles.red,
                      //       borderRadius: BorderRadius.only(
                      //         topLeft: Radius.circular(ThemeStyles.setWidth(3)),
                      //         topRight:
                      //             Radius.circular(ThemeStyles.setWidth(3)),
                      //       )),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Icon(Icons.delete_forever_outlined,color: ThemeStyles.red,size:ThemeStyles.setHeight(100) ,)
                        // Image.asset(
                        //   "assets/images/alarm_icon.png",
                        //   height: ThemeStyles.setHeight(100),
                        // ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate("delAccount"),
                              style: ThemeStyles.regularStyle().copyWith(
                                  color: ThemeStyles.lightGrey, height: 1.7),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          // ThemeStyles.space(),
                          Divider(
                            thickness: ThemeStyles.setHeight(1),
                            height: ThemeStyles.setHeight(0),
                          ),
                          Padding(
                            padding: EdgeInsets.all(
                              ThemeStyles.setWidth(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(
                                          ThemeStyles.setWidth(15)),
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .translate("back"),
                                        textAlign: TextAlign.center,
                                        style: ThemeStyles.regularStyle()
                                            .copyWith(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      AppFuture.deleteAccount(context).then(
                                        (isDeleted) {
                                          if (isDeleted) {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                            signOut();
                                            navigateToMain();
                                          }
                                        },
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: ThemeStyles.red,
                                        borderRadius: BorderRadius.circular(
                                          ThemeStyles.setWidth(8),
                                        ),
                                      ),
                                      padding: EdgeInsets.all(
                                          ThemeStyles.setWidth(10)),
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .translate("ensureDelAccount"),
                                        textAlign: TextAlign.center,
                                        style: ThemeStyles.boldStyle()
                                            .copyWith(color: ThemeStyles.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim),
          child: child,
        );
      },
    );
  }

}

