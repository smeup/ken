import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';

class SmeupNavigationAppBar extends AppBar {
  final BuildContext myContext;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;
  final bool backButtonVisible;
  final List<Widget> appBarActions;
  final String barTitle;
  static bool isBusy = false;

  SmeupNavigationAppBar(bool isDialog,
      {Key key,
      this.appBarActions,
      this.barTitle,
      this.myContext,
      this.scaffoldKey,
      this.formKey,
      this.backButtonVisible = true})
      : super(
            key: key,
            automaticallyImplyLeading: !isDialog,
            leading: backButtonVisible
                ? IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(myContext, false),
                  )
                : Container(),
            title: Center(
                child: Text(
              barTitle ?? '',
              key: Key('appbar_text'),
            )),
            backgroundColor: isDialog
                ? SmeupConfigurationService.getTheme().scaffoldBackgroundColor
                : SmeupConfigurationService.getTheme().primaryColor,
            elevation: isDialog ? 0 : 10,
            actions: appBarActions);
}
