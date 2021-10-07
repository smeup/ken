import 'package:mobile_components_library/smeup/models/widgets/smeup_list_box_model.dart';

import 'smeup_dao.dart';

class SmeupListBoxDao extends SmeupDao {
  static Future<void> getData(SmeupListBoxModel model) async {
    await SmeupDao.getData(model);
  }
}
