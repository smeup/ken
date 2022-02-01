import 'package:ken/smeup/models/smeup_fun.dart';
import 'package:ken/smeup/services/smeup_service_response.dart';
import 'package:ken/smeup/services/transformers/smeup_data_transformer_interface.dart';

abstract class SmeupDataServiceInterface {
  SmeupDataTransformerInterface transformer;

  SmeupDataServiceInterface(SmeupDataTransformerInterface transformer) {
    this.transformer = transformer;
  }

  // ignore: missing_return
  Future<SmeupServiceResponse> invoke(SmeupFun fun) {}

  SmeupDataTransformerInterface getTransformer() {
    return this.transformer;
  }
}
