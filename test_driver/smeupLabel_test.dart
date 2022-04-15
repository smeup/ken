// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:integration_test/integration_test.dart';
import 'package:test/test.dart';

import 'integration_test_service.dart';

late FlutterDriver driver;

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final button =
      find.ancestor(of: find.text('LABEL'), matching: find.byType('Text'));

  group('smeupLabel group -> ', () {
    IntegrationTestService.initTests();

    // final align =
    //     find.ancestor(of: find.text('LABEL'), matching: find.byType('Align'));

    // final row = find.ancestor(of: align, matching: find.byType('Row'));

    // final container =
    //     find.ancestor(of: row, matching: find.byType('Container'));

    // final column =
    //     find.ancestor(of: container, matching: find.byType('Column'));

    // final button =
    //     find.ancestor(of: column, matching: find.byType('ElevatedButton'));

    // final findButtonWithDescendant = find.descendant(
    //     of: find.byType('SmeupForm'), matching: find.byType('ElevatedButton'));

    //final btn1 = find.byValueKey('BTN69_1');

    test('execute dynamic', () async {
      await driver.tap(button);
      await driver.waitFor(find.text("LABEL 1"));
    });
  });
}
