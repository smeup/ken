import 'package:mobile_components_library/smeup/models/widgets/smeup_text_field_model.dart';
import 'smeup_dao.dart';

class SmeupTextFieldDao extends SmeupDao {
  static Future<void> getData(SmeupTextFieldModel model) async {
    await SmeupDao.getData(model);
  }
}
