import 'package:mobile_components_library/smeup/models/widgets/smeup_datepicker_model.dart';
import 'smeup_dao.dart';

class SmeupDatePickerDao extends SmeupDao {
  static Future<void> getData(SmeupDatePickerModel model) async {
    await SmeupDao.getData(model);
  }
}
