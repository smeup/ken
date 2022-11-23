// import 'package:flutter_treeview/tree_view.dart';
import 'package:ken/smeup/models/widgets/smeup_buttons_model.dart';
import 'smeup_dao.dart';

class SmeupButtonsDao extends SmeupDao {
  static Future<void> getData(SmeupButtonsModel model) async {
    await SmeupDao.getData(model);
  }
}
