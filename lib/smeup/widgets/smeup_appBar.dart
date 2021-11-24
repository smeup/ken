import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_image.dart';

class SmeupAppBar extends AppBar {
  final BuildContext myContext;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;
  final bool backButtonVisible;
  final List<Widget> appBarActions;
  final String appBarTitle;
  final String appBarImage;
  static bool isBusy = false;

  SmeupAppBar(bool isDialog,
      {Key key,
      this.appBarActions,
      this.appBarTitle,
      this.myContext,
      this.scaffoldKey,
      this.formKey,
      this.appBarImage = '',
      this.backButtonVisible = true})
      : super(
            key: key,
            iconTheme: _getIconTheme(),
            titleTextStyle: _getTextStile(isDialog),
            automaticallyImplyLeading: !isDialog,
            leading: _getLeadingButton(backButtonVisible, myContext),
            title: _getTitle(appBarImage, appBarTitle, scaffoldKey, formKey),
            backgroundColor: _getTextStile(isDialog).backgroundColor,
            elevation: isDialog ? 0 : 10,
            actions: appBarActions);

  static Widget _getLeadingButton(
      bool backButtonVisible, BuildContext myContext) {
    return backButtonVisible
        ? IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(myContext, false),
          )
        : Container();
  }

  static Widget _getTitle(String appBarImage, String appBarTitle,
      GlobalKey<ScaffoldState> scaffoldKey, GlobalKey<FormState> formKey) {
    double imageSize = 70.0;
    if (appBarImage.isNotEmpty) {
      return Center(
        child: SmeupImage(scaffoldKey, formKey, appBarImage,
            isRemote: true, height: imageSize, width: imageSize),
      );
    } else if (SmeupConfigurationService.appBarImage.isNotEmpty) {
      return Center(
        child: SmeupImage(scaffoldKey, formKey,
            '${SmeupConfigurationService.imagesPath}/${SmeupConfigurationService.appBarImage}',
            isRemote: false, height: imageSize, width: imageSize),
      );
    } else {
      return Center(
          child: Text(
        appBarTitle ?? '',
        key: Key('appbar_text'),
      ));
    }
  }

  static TextStyle _getTextStile(isDialog) {
    TextStyle style = isDialog
        ? SmeupConfigurationService.getTheme().textTheme.headline2
        : SmeupConfigurationService.getTheme().textTheme.headline1;

    return style;
  }

  static IconThemeData _getIconTheme() {
    IconThemeData themeData = SmeupConfigurationService.getTheme().iconTheme;

    return themeData;
  }
}
