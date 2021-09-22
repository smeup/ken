import 'package:mobile_components_library/smeup/models/widgets/smeup_timepicker_model.dart';

import 'smeup_dao.dart';

class SmeupTimePickerDao extends SmeupDao {
  static Future<void> getData(SmeupTimePickerModel model) async {
    return SmeupDao.getData(model);
  }
}
