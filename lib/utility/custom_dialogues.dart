import 'dart:math';

import 'package:englishindustry/utility/static_content.dart';
import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/utility/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:urwaypayment/urwaypayment.dart';

import '../payment_gate/receipt_updated_page.dart';
import 'future.dart';

abstract class CustomDialogues {


  static void showSubscriptionDialog(
      BuildContext context,
      int kidsPrice,
      int growPlanPrice,
      String kidsId,
      String growId,
      String uName,
      String uEmail,
      int currentSubPlan,
      String kidsTitle,
      String growTitle) {   
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      context: context,
      pageBuilder: (_, __, ___) {

        bool growBool=false;


        var v1 = Random().nextInt(20000000);

        if (kDebugMode) {
          print(v1);
        }
        Future<void> _performtrxn(BuildContext context, String transType,{int amount,
          String customerEmail,
          String customerName,
          String orderId,}
            ) async {
          var lastResult = "";
          var decodeSucceeded = false;
          if (transType == "hosted") {
            // on Apple Click call other method  check with if else
            lastResult = await Payment.makepaymentService(
                context: context,
                country: "SA",
                action: "1",
                currency: "SAR",
                amt: amount.toString(),
                customerEmail:customerEmail ,
                trackid: v1.toString(),
                udf1: "",
                udf2: "",

                udf3:"",
                udf4:"",
                udf5: "",
                cardToken: "",
                address: "",
                city: "jeddah",
                state: "XYZ",
                tokenizationType: "1",
                zipCode: "",
                tokenOperation: "A/U/D");

            if (kDebugMode) {
              print('Result in Main is $lastResult');
            }
            decodeSucceeded = true;
          } else if (transType == "applepay") {
            if (kDebugMode) {
              print("In apple pay");
            }
            lastResult = await Payment.makeapplepaypaymentService(
                context: context,
                country: "SA",
                action: "1",
                currency: "SAR",
                amt: amount.toString(),
                customerEmail: customerEmail ,
                trackid: v1.toString(),
                udf1: "",
                udf2: "",

                udf3:"",
                udf4:"",
                udf5: "",
                tokenizationType: "1",
                merchantIdentifier: "merchant.com.englishIndustry",
                shippingCharge: "0.00",
                companyName: customerName);
            if (kDebugMode) {
              print('Result on Apple Pay in Main is $lastResult');
            }
            decodeSucceeded = true;
          }

          if (decodeSucceeded) {
            if (lastResult.isNotEmpty) {
              if (kDebugMode) {
                print('Show');
              }
              // ignore: use_build_context_synchronously
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ReceiptUpdatedPage(lastResult,growId)));
              if (lastResult.contains("Successful")==true &&
                  lastResult.contains("000")==true &&
                  lastResult.contains("unSuccessful")!=true) {
                if (kDebugMode) {
                  print('payment is done');
                }
                AppFuture.subscripe(context,growBool==true?growId:kidsId);
              } else {
                if (kDebugMode) {
                  print('payment is fail');
                }
              }
            } else {
              if (kDebugMode) {
                print('Show Blank Data');
              }
            }
          }
          if (kDebugMode) {
            print('Payment : $lastResult');
          }
          if (lastResult.contains("Successful")==true &&lastResult.contains("000")==true) {  if (kDebugMode) {
            print(
              'is the transaction true  }');
          }}else{if (kDebugMode) {
            print(
              'is the transaction false  }');
          }


          }
        }
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
                        Radius.circular(ThemeStyles.setWidth(5)),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: ThemeStyles.setWidth(80),
                        height: ThemeStyles.setHeight(5),
                        margin: EdgeInsets.only(top: ThemeStyles.setHeight(10)),
                        decoration: BoxDecoration(
                            color: ThemeStyles.red,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(ThemeStyles.setWidth(3)),
                              topRight:
                                  Radius.circular(ThemeStyles.setWidth(3)),
                            )),
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: ()async {
                              Navigator.of(context, rootNavigator: true).pop();
                              if (kDebugMode) {
                                print("id :::::grow::::::::$growId");
                              }
                              growBool=true;
                              await   _performtrxn(context, "hosted",
                                amount: growPlanPrice,
                                customerEmail: uEmail,
                                customerName: uName,
                                orderId: v1.toString(),

                              );

                            },
                            child: StaticContent.changPlan(
                                growTitle, ThemeStyles.red, growPlanPrice),
                          ),
                          ThemeStyles.space(),
                          if (currentSubPlan == 0)
                            Column(
                              children: [

                                InkWell(
                                  onTap: () async{
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                    if (kDebugMode) {
                                      print("id ::::kids:::::::::$kidsId");
                                    }
                                    growBool=false;
                                    await   _performtrxn(context, "hosted",
                                      amount: growPlanPrice,
                                      customerEmail: uEmail,
                                      customerName: uName,
                                      orderId: v1.toString(),

                                    );

                                  },
                                  child: StaticContent.changPlan(
                                      kidsTitle, ThemeStyles.red, kidsPrice),
                                ),
                              ],
                            )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)
                                .translate("choosePlan"),
                            style: ThemeStyles.boldStyle().copyWith(
                                color: ThemeStyles.lightGrey, height: 1.7),
                            textAlign: TextAlign.center,
                          ),
                          ThemeStyles.halfSpace(),
                          Divider(
                            thickness: ThemeStyles.setHeight(1),
                            height: ThemeStyles.setHeight(0),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                            child: Container(
                              padding: EdgeInsets.all(ThemeStyles.setWidth(15)),
                              width: ThemeStyles.setFullWidth(),
                              child: Text(
                                AppLocalizations.of(context).translate("back"),
                                textAlign: TextAlign.center,
                                style: ThemeStyles.regularStyle()
                                    .copyWith(color: ThemeStyles.grey),
                              ),
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
