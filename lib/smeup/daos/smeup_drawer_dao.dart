import 'package:ken/smeup/models/widgets/smeup_drawer_model.dart';
import 'smeup_dao.dart';

class SmeupDrawerDao extends SmeupDao {
  static Future<void> getData(SmeupDrawerModel model) async {
    await SmeupDao.getData(model);
  }
}
