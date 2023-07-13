import '../services/ken_data_service.dart';
import 'ken_dao.dart';

extension KenDaoInputPanel on KenDao {
  Future<void> getDataQRCodeReader() async {
    // ignore: unnecessary_null_comparison
    if (KenDataService.isRegistered) {
      KenDataService.dataInitializer.getDataQRCodeReader(smeupModel!);
    }
  }
}
