import 'package:ken/smeup/models/widgets/smeup_radio_buttons_model.dart';
import 'smeup_dao.dart';

class SmeupRadioButtonsDao extends SmeupDao {
  static Future<void> getData(SmeupRadioButtonsModel model) async {
    await SmeupDao.getData(model);
  }
}
