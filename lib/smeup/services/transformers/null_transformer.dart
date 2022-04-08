import 'package:ken/smeup/services/transformers/smeup_data_transformer_interface.dart';

import '../../models/fun.dart';

class NullTransformer implements SmeupDataTransformerInterface {
  @override
  transform(SmeupFun smeupFun, data) {
    return data;
  }
}
