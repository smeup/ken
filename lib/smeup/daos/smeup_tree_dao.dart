import 'package:ken/smeup/models/widgets/smeup_tree_model.dart';

import 'smeup_dao.dart';

class SmeupTreeDao extends SmeupDao {
  static Future<void> getData(SmeupTreeModel model) async {
    await SmeupDao.getData(model);
  }
}
