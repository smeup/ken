import 'package:ken/smeup/models/widgets/smeup_gauge_model.dart';
import 'smeup_dao.dart';

class SmeupGaugeDao extends SmeupDao {
  static Future<void> getData(SmeupGaugeModel model) async {
    await SmeupDao.getData(model);
  }
}
