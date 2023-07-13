import 'dart:async';

import '../models/widgets/ken_model.dart';
import '../services/ken_data_service.dart';

class KenDao {
  KenModel? smeupModel;

  KenDao();

  Future<void> getValidation() async {
    await KenDataService.dataInitializer.getValidation(smeupModel!);
  }

  dynamic getClientDataStructure() {
    var structure = KenDataService.dataInitializer.getClientDataStructure(smeupModel!);
    return structure;
  }

  Future<dynamic> getData() {
    return KenDataService.dataInitializer.getData(smeupModel!);
  }
}
