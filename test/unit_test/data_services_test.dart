import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/models/smeup_fun.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';

import 'unit_test_service.dart';

void main() {
  test('test SmeupJsonDataService', () async {
    await UnitTestService.initTests();

    var smeupFun = SmeupFun('F(EXD;*JSN;) 2(;;test_dynamic_screen)', null);
    expect(smeupFun.fun['fun']['service'], '*JSN');

    final res = await SmeupDataService.invoke(smeupFun);

    expect(res.succeded, true);
  });

  test('test SmeupHttpDataService', () async {
    await UnitTestService.initTests();

    var smeupFun = SmeupFun('F(;*HTTP;)', null);
    expect(smeupFun.fun['fun']['service'], '*HTTP');

    final res = await SmeupDataService.invoke(
      smeupFun,
      httpServiceMethod: 'get',
      httpServiceUrl:
          '${SmeupConfigurationService.getHttpServiceEndpoint()}/metrics',
      httpServiceContentType: 'application/x-www-form-urlencoded',
      httpServiceBody: {},
    );

    expect(res.succeded, true);
  }, skip: true);
}
