// import 'package:englishindustry/utility/theme_styles.dart';
// import 'package:flutter/material.dart';
//
// class BackPressHeader extends StatelessWidget {
//   final String title;
//   const BackPressHeader({
//     Key key,
//     @required this.title,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: ThemeStyles.setFullWidth(),
//       height: ThemeStyles.setHeight(120),
//       padding: EdgeInsets.only(
//         top: ThemeStyles.setHeight(0),
//         left: ThemeStyles.setWidth(15),
//         right: ThemeStyles.setWidth(15),
//       ),
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage("assets/images/home_header.png"),
//           fit: BoxFit.fitWidth,
//         ),
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(ThemeStyles.setWidth(10)),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 InkWell(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Icon(
//                     Icons.arrow_back_ios,
//                     color: ThemeStyles.white,
//                   ),
//                 ),
//               ],
//             ),
//             Text(
//               "( $title )",
//               style: ThemeStyles.boldStyle().copyWith(
//                 color: ThemeStyles.red,
//                 fontSize: ThemeStyles.setWidth(18),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
