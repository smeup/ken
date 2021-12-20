import 'package:ken/smeup/models/widgets/smeup_calendar_model.dart';
import 'smeup_dao.dart';

class SmeupCalendarDao extends SmeupDao {
  static Future<void> getData(SmeupCalendarModel model) async {
    await SmeupDao.getData(model);
  }
}
