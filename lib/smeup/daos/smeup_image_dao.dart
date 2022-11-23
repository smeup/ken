import 'package:ken/smeup/models/widgets/smeup_image_model.dart';
import 'smeup_dao.dart';

class SmeupImageDao extends SmeupDao {
  static Future<void> getData(SmeupImageModel model) async {
    await SmeupDao.getData(model);
  }
}
