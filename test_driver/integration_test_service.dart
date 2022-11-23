import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'authentication_test.dart';

class IntegrationTestService {
  static String testUserName = 'antonio.cosentino@smeup.com';
  static String testPassword = 'password345';

  static bool isInitialized = false;
  static initTests() async {
    if (isInitialized) return;
    isInitialized = true;
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      driver.close();
    });
  }

  static executeLogin() async {
    final emailText = find.byValueKey('email_text');
    final passwordText = find.byValueKey('password_text');
    final loginButton = find.byValueKey('loginButton');

    await driver.tap(emailText);
    await driver.enterText(testUserName);
    await driver.tap(passwordText);
    await driver.enterText(testPassword);

    await driver.tap(loginButton);
  }

  static executeLogout() async {
    //final logoutButton = find.byValueKey('logoutButton');
    final logoutButton = find.byValueKey('appbar_icon_58291');
    //final logoutButton = find.byType('Icon');

    final confirmLogoutButton = find.byValueKey('confirmLogoutButton');

    await driver.tap(logoutButton);
    await driver
        .waitFor(find.text("vuoi davvero disconnettere il tuo account?"));
    await driver.tap(confirmLogoutButton);
  }
}
