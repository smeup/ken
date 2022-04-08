import 'package:ken/smeup/services/smeup_service_response.dart';
import 'package:ken/smeup/services/transformers/null_transformer.dart';
import 'package:ken/smeup/services/transformers/smeup_data_transformer_interface.dart';

import '../models/fun.dart';

abstract class SmeupDataServiceInterface {
  SmeupDataTransformerInterface? transformer;

  SmeupDataServiceInterface(SmeupDataTransformerInterface? transformer) {
    if (transformer == null) transformer = NullTransformer();
    this.transformer = transformer;
  }

  // ignore: missing_return
  Future<SmeupServiceResponse> invoke(SmeupFun fun) {
    throw ('not implemented');
  }

  SmeupDataTransformerInterface? getTransformer() {
    return this.transformer;
  }
}
