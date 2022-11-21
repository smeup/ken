import 'package:ken/smeup/services/transformers/ken_data_transformer_interface.dart';

import '../../models/fun.dart';

class NullTransformer implements KenDataTransformerInterface {
  @override
  transform(Fun smeupFun, data) {
    return data;
  }
}
