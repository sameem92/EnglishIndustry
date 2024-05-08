import 'package:englishindustry/components/details_component.dart';
import 'package:englishindustry/components/week_children_component.dart';
import 'package:englishindustry/components/week_component.dart';
import 'package:flutter/material.dart';

class UserHomeContent extends StatefulWidget {
  final int homeType;
  final Map<String, dynamic> data;
  final List<dynamic> myWeeks, kidsWeeks;
  final bool isUserHome;

  const UserHomeContent({
    Key key,
    @required this.homeType,
    @required this.data,
    @required this.myWeeks,
    @required this.kidsWeeks,
    @required this.isUserHome,
  }) : super(key: key);

  @override
  State<UserHomeContent> createState() => _UserHomeContentState();
}

class _UserHomeContentState extends State<UserHomeContent> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            widget.homeType == 0
                ? Weeks(
                    data: widget.data,
                    myWeeks: widget.myWeeks,
                    isUserHome: widget.isUserHome,
                  )
                : WeeksForChildren(
                    data: widget.data,
                    kidsWeeks: widget.kidsWeeks,
                    isUserHome: widget.isUserHome,
                  ),
            Details(
              data: widget.data,
              myWeeks: widget.myWeeks,
              kidsWeeks: widget.kidsWeeks,
              homeType: widget.homeType,
              isUserHome: widget.isUserHome,
            ),
          ],
        ),
      ),
    );
  }
}
