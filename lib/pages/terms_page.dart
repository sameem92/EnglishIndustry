import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/utility/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class Terms extends StatefulWidget {
  final Map<String, dynamic> data;
  const Terms({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        backgroundColor: ThemeStyles.offWhite,
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
            AppLocalizations.of(context).translate("termCondition"),
            style: ThemeStyles.boldStyle().copyWith(
                color: ThemeStyles.red, fontSize: ThemeStyles.setWidth(14)),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: ThemeStyles.setWidth(30),
            vertical: ThemeStyles.setHeight(10),
          ),
          width: ThemeStyles.setFullWidth(),
          height: ThemeStyles.setFullHeight(),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Html(
                    data: widget.data["terms"],
                    style: {
                      "p": Style(
                        fontFamily: "Product",
                      ),
                    },
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
