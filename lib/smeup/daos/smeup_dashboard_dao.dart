import 'package:ken/smeup/models/widgets/smeup_dashboard_model.dart';
import 'smeup_dao.dart';

class SmeupDashboardDao extends SmeupDao {
  static Future<void> getData(SmeupDashboardModel model) async {
    await SmeupDao.getData(model);
  }
}
