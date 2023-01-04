import 'package:ken/smeup/daos/ken_dao.dart';
import 'package:ken/smeup/models/widgets/ken_model_callback.dart';

extension KenDaoInputPanel on KenDao {
  Future<void> getDataQRCodeReader() async {
    // ignore: unnecessary_null_comparison
    if (instanceCallBack != null) {
      instanceCallBack(
          ServicesCallbackType.getDataQRCodeReader, null, smeupModel);
    }
  }
}
