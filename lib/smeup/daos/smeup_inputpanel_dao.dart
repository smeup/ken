import 'package:mobile_components_library/smeup/models/widgets/smeup_inputpanel_model.dart';

import 'smeup_dao.dart';

class SmeupInputPanelDao extends SmeupDao {
  static Future<void> getData(SmeupInputPanelModel model) async {
    await SmeupDao.getData(model);
  }
}
