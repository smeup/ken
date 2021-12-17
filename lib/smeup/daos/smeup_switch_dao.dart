import 'package:mobile_components_library/smeup/models/widgets/smeup_switch_model.dart';

import 'smeup_dao.dart';

class SmeupSwitchDao extends SmeupDao {
  static Future<void> getData(SmeupSwitchModel model) async {
    await SmeupDao.getData(model);
  }
}
