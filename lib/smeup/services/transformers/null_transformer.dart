import '../../models/fun.dart';
import 'ken_data_transformer_interface.dart';

class NullTransformer implements KenDataTransformerInterface {
  @override
  transform(Fun smeupFun, data) {
    return data;
  }
}
