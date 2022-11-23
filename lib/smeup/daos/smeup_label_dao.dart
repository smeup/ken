import 'package:ken/smeup/models/widgets/smeup_label_model.dart';

import 'smeup_dao.dart';

class SmeupLabelDao extends SmeupDao {
  static Future<void> getData(SmeupLabelModel model) async {
    await SmeupDao.getData(model);
  }
}
