// ignore_for_file: file_names, avoid_print

import 'package:englishindustry/payment_gate/resp_data_model.dart';
import 'package:flutter/material.dart';

import '../pages/splash_page.dart';
import '../utility/app_localizations.dart';
import '../utility/theme_styles.dart';


class ReceiptUpdatedPage extends StatefulWidget {
  final String respFinalData;
  final String idPlan;
  // ignore: use_key_in_widget_constructors
  const ReceiptUpdatedPage(this.respFinalData,this.idPlan);

  @override
  // ignore: library_private_types_in_public_api
  _MyReceiptPage createState() => _MyReceiptPage();
}

class _MyReceiptPage extends State<ReceiptUpdatedPage> {
   Map<String, dynamic> mapResp;
  bool visibilityToken = false;
  List list = [];
  Map<String, String> mapData = {};
   String myData;

  void _visibleDataList() {
    if (!mounted) {
    } else {
      setState(() {
        var dataSp = widget.respFinalData.split(',');
        // print(widget.respFinalData);

        for (var element in dataSp) {
         print(mapData[element.split(':')[0]] = element.split(':')[1]);
         // mapData[element.split(':')[0]] = element.split(':')[1];
        }
        // print(mapData.keys);

        // mapResp = widget.respFinalData;
        mapData
            .forEach((k, v) => list.add(RespDataModel(resKey: k, resValue: v)));
        // print(list);
      });
    }
  }

  String getstrfromList(String strlistrowvalue) {
    myData = strlistrowvalue.replaceAll(RegExp('[{}]'), '');
    // print(myData);
    return myData;
  }

  //}

  @override
  void initState() {
    super.initState();
    _visibleDataList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ThemeStyles.offWhite,
        appBar:AppBar(  backgroundColor: ThemeStyles.offWhite,
          toolbarHeight: ThemeStyles.setHeight(60),
          centerTitle: true,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          leadingWidth: ThemeStyles.setWidth(80),
          title: Text(
            AppLocalizations.of(context).translate("payment"),
            style: ThemeStyles.regularStyle().copyWith(
                color: ThemeStyles.red, fontSize: ThemeStyles.setWidth(18)),
          ),),
        body: Column(
          children: <Widget>[
            Expanded(
              child: tableBody(
                context,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            // SizedBox(
            //   width: 270,
            //   child: ElevatedButton(
            //     style: ButtonStyle(backgroundColor: ),
            //
            //     child: Text(
            //       widget.respFinalData.contains("Successful")
            //           ? 'اكمل'
            //           : "الرجوع"),
            //       // width: double.infinity,
            //       // : ThemeStyles.white,
            //       // sideColor: kSpecialColor,
            //     onPressed: () async {
            //     widget.respFinalData.contains("Successful")
            //         &&
            //         widget.respFinalData.contains("000")==true &&
            //         widget.respFinalData.contains("unSuccessful")!=true
            //
            //     ?print('success')
            //     // Navigator.pushReplacement(
            //     //     context,
            //     //
            //     //          MaterialPageRoute(
            //     //             builder: (context) => const MainScreen(
            //     //                   currentIndex: 1,
            //     //                   orderIndex: 0,
            //     //                 )))
            //         :Navigator.pop(context);
            //     // :Navigator.
            //         // MaterialPageRoute(
            //         //         builder: (context) => const MainScreen(
            //         //               currentIndex: 2,
            //         //               orderIndex: 0,
            //         //             )));
            //   }, ),
            // ),
            GestureDetector(
              onTap: (){

    // AppFuture.checkConnection(context).then((value) {
    //       if (value) {
    //         AppFuture.subscripe(context, result.orderDescription).then((value) {
    //           if (value != null) {

                if(widget.respFinalData.contains("Successful")
                    &&
                    widget.respFinalData.contains("000")==true &&
                    widget.respFinalData.contains("unSuccessful")!=true) {


                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                      const MainProvider(
                        isPaymentProvider: true,
                      ),
                    ),
                        (route) => true,
                  );
                  // }
                }else{
                  Navigator.pop(context);

                }

              },
              child: Container(
                width: ThemeStyles.setWidth(180),
                padding: EdgeInsets.symmetric(
                  horizontal: ThemeStyles.setWidth(25),
                  vertical: ThemeStyles.setWidth(10),
                ),
                decoration: BoxDecoration(
                  color: ThemeStyles.red,
                  borderRadius: BorderRadius.circular(
                    ThemeStyles.setWidth(30),
                  ),
                ),
                child: Column(
                  children: [
                    Text(

                      widget.respFinalData.contains("Successful")
                              &&
                              widget.respFinalData.contains("000")==true &&
                              widget.respFinalData.contains("unSuccessful")!=true
                  ?   AppLocalizations.of(context).translate("startYourCourse")

                      : AppLocalizations.of(context).translate("PaymentFailed"),
                      textAlign: TextAlign.center,
                      style: ThemeStyles.boldStyle().copyWith(
                        color: ThemeStyles.white,
                      ),
                    ),

                  ],
                ),
              ),
            ),


            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView tableBody(BuildContext ctx) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            DataTable(
              dataRowHeight: 50,
              dividerThickness: 5,
              columns: const [
                DataColumn(
                  label: Text('key',),
                  numeric: false,
                  tooltip: "This is First Name",
                ),
                DataColumn(
                  label: Text('value', ),
                  numeric: false,
                  tooltip: "This is Values",
                ),
              ],
              rows: list
                  .map(
                    (list) => DataRow(cells: [
                      DataCell(
                        Text(getstrfromList(list.resKey)),
                      ),
                      DataCell(
                        Text(getstrfromList(list.resValue)),
                      ),
                    ]),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
