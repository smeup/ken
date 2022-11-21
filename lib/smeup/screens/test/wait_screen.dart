// import 'package:flutter/material.dart';
// import 'package:ken/smeup/screens/test/showcase_shared.dart';
// import 'package:ken/smeup/widgets/smeup_wait.dart';
//
// import '../../services/ken_theme_configuration_service.dart';
//
// class WaitScreen extends StatelessWidget {
//   static const routeName = '/WaitScreen';
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
//             title: Center(child: Text('Wait Screen')),
//             actions: ShowCaseShared.getEmptyAction(),
//           ),
//           body: SmeupWait(_scaffoldKey, _formKey, id: 'wait1'),
//         ),
//       ),
//     );
//   }
// }
