import 'package:ken/smeup/models/widgets/smeup_progress_bar_model.dart';
import 'smeup_dao.dart';

class SmeupProgressBarDao extends SmeupDao {
  static Future<void> getData(SmeupProgressBarModel model) async {
    await SmeupDao.getData(model);
  }
}
