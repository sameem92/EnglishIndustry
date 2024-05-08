// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class ReceiptPage extends StatefulWidget {
  final String transId;
  final String result;
  final String amount;

  final String cardToken;
  final String cardBrand;
  // ignore: non_constant_identifier_names
  final String MaskedPan;

  // ignore: use_key_in_widget_constructors
  const ReceiptPage(this.transId, this.result, this.amount, this.cardToken,
      this.cardBrand, this.MaskedPan);

  @override
  // ignore: library_private_types_in_public_api
  _MyReceiptPage createState() => _MyReceiptPage();
}

class _MyReceiptPage extends State<ReceiptPage> {
  bool visibilityToken = false;

  void _visibleTokenDetails() {
    setState(() {
      var tok = widget.cardToken;
      // print('Token $tok');
      if (tok == "" || tok == "null") {
        // print('Token if$tok');
        visibilityToken = false;
      } else {
        // print('Token else$tok');
        visibilityToken = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _visibleTokenDetails();
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Urway Receipt'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text.rich(
              TextSpan(
                text: '', // default text style

                children: <TextSpan>[
                  TextSpan(
                      text: 'Order Summary',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24.0)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
              child: Text.rich(
                TextSpan(
                  text: 'Invoice Order # ', // default text style
                  children: <TextSpan>[
                    TextSpan(
                        text: widget.transId,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            Text.rich(
              TextSpan(
                text: 'Transaction is ', // default text style
                children: <TextSpan>[
                  TextSpan(
                      text: widget.result,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                text: 'Order Date ', // default text style
                children: <TextSpan>[
                  TextSpan(
                      text: '$now',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                text: 'Amount ', // default text style
                children: <TextSpan>[
                  TextSpan(
                      text: widget.amount,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                text: 'Card Brand ', // default text style
                children: <TextSpan>[
                  TextSpan(
                      text: widget.cardBrand,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                text: 'Masked Card No. ', // default text style
                children: <TextSpan>[
                  TextSpan(
                      text: widget.MaskedPan,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),


            visibilityToken
                ? const Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text.rich(
                  TextSpan(
                      children: <TextSpan> [
                        TextSpan(
                            text: 'Token Deatils',
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                      ]
                  )
              ),
            )
                : Container(),

            visibilityToken
                ? const Text.rich(
              TextSpan(
                  text: 'Card Token',
                  children: <TextSpan> [
                    TextSpan(
                        text: 'Card Token',
                        style: TextStyle(fontWeight: FontWeight.bold)
                    ),
                  ] ),
            )
                : Container(),




            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // <-- Radius
                ),
              ),
              child: const Text(
                "New Transaction",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
