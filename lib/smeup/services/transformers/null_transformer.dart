import 'package:ken/smeup/models/smeup_fun.dart';
import 'package:ken/smeup/services/transformers/smeup_data_transformer_interface.dart';

class NullTransformer implements SmeupDataTransformerInterface {
  @override
  transform(SmeupFun smeupFun, data) {
    return data;
  }
}
