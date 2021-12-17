import 'package:ken/smeup/models/widgets/smeup_line_model.dart';
import 'smeup_dao.dart';

class SmeupLineDao extends SmeupDao {
  static Future<void> getData(SmeupLineModel model) async {
    await SmeupDao.getData(model);
  }
}
