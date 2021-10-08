import 'package:mobile_components_library/smeup/models/widgets/smeup_carousel_model.dart';
import 'smeup_dao.dart';

class SmeupCarouselDao extends SmeupDao {
  static Future<void> getData(SmeupCarouselModel model) async {
    await SmeupDao.getData(model);
  }
}
