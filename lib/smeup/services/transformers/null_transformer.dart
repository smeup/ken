import 'package:ken/smeup/services/transformers/smeup_data_transformer_interface.dart';

import '../../models/fun.dart';

class NullTransformer implements SmeupDataTransformerInterface {
  @override
  transform(Fun smeupFun, data) {
    return data;
  }
}
