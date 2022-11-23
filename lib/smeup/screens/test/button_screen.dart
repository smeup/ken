// import 'package:flutter/material.dart';
// import 'package:ken/smeup/widgets/ken_buttons.dart';
// import 'package:ken/smeup/screens/test/showcase_shared.dart';
// import 'package:ken/smeup/services/shiro_utilities.dart';
//
// import '../../services/ken_theme_configuration_service.dart';
//
// class ButtonScreen extends StatelessWidget {
//   static const routeName = '/ButtonScreen';
//   static const description =
//       'This Button has the ability to include all the Flutter buttons features';
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeConfigurationService.getTheme()!,
//       child: Builder(
//         builder: (BuildContext context) => Scaffold(
//           appBar: AppBar(
//             title: Center(child: Text('Button')),
//             actions: ShowCaseShared.getEmptyAction(),
//           ),
//           body: SingleChildScrollView(
//             child: Container(
//               padding: const EdgeInsets.all(30),
//               //child: Padding(
//               //padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
//               child: Center(
//                   child: Column(
//                 children: [
//                   ShowCaseShared.getTestLabel(
//                       _scaffoldKey, _formKey, description),
//                   SmeupButtons(
//                     _scaffoldKey,
//                     _formKey,
//                     //width: double.infinity,
//                     id: 'buttons',
//                     data: ['Click me'],
//                     height: 80,
//                     width: 260,
//                     iconCode: 62371,
//                     iconSize: 25,
//                     borderRadius: 30,
//                     fontSize: 18,
//                     backColor: Color.fromRGBO(6, 140, 154, 10),
//                     fontColor: Colors.white,
//                     align: Alignment.centerRight,
//                     clientOnPressed: (buttonIndex, buttonText) {
//                       SmeupUtilities.invokeScaffoldMessenger(context,
//                           "You have clicked the button with text \"$buttonText\" ");
//                     },
//                   ),
//                 ],
//               )),
//               //),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
