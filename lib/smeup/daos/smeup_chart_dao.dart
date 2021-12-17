import 'package:mobile_components_library/smeup/models/widgets/smeup_chart_model.dart';
import 'smeup_dao.dart';

class SmeupChartDao extends SmeupDao {
  static Future<void> getData(SmeupChartModel model) async {
    await SmeupDao.getData(model);
  }
}
