// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:integration_test/integration_test.dart';
import 'package:test/test.dart';

import 'integration_test_service.dart';

late FlutterDriver driver;

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('login group -> ', () {
    IntegrationTestService.initTests();

    final appBarText = find.byValueKey('appbar_text');

    test('check that it\'s not logged in', () async {
      expect(await driver.getText(appBarText), "ACCEDI");
    });

    test('execute login', () async {
      await IntegrationTestService.executeLogin();
      await driver.waitFor(find.text("HOME"));
      expect(await driver.getText(find.text("HOME")), "HOME");
    });
  }, skip: true);

  group('logout group -> ', () {
    IntegrationTestService.initTests();

    final appBarText = find.byValueKey('appbar_text');

    test('check that it\'s not logged out', () async {
      expect(await driver.getText(appBarText), "HOME");
    });

    test('execute logout', () async {
      await IntegrationTestService.executeLogout();
      await driver.waitFor(find.text("ACCEDI"));
      expect(await driver.getText(find.text("ACCEDI")), "ACCEDI");
    });
  }, skip: true);
}
