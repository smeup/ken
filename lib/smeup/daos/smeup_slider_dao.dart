import 'package:mobile_components_library/smeup/models/widgets/smeup_slider_model.dart';

import 'smeup_dao.dart';

class SmeupSliderDao extends SmeupDao {
  static Future<void> getData(SmeupSliderModel model) async {
    await SmeupDao.getData(model);
  }
}
