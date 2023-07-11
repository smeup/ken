import '../models/widgets/ken_model_callback.dart';
import 'ken_dao.dart';

extension KenDaoInputPanel on KenDao {
  Future<void> getDataQRCodeReader() async {
    // ignore: unnecessary_null_comparison
    if (instanceCallBack != null) {
      instanceCallBack(
          ServicesCallbackType.getDataQRCodeReader, null, smeupModel);
    }
  }
}
