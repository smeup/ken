import 'ken_data_initializer_interface.dart';

class KenDataService {
  static late KenDataInitializerInterface _dataInitializer;
  static bool _isRegistered = false;

  static KenDataInitializerInterface get dataInitializer => _dataInitializer;
  static bool get isRegistered => _isRegistered;

  static void registerDataInitializer(KenDataInitializerInterface dataInitializer) {
    _dataInitializer = dataInitializer;
    _isRegistered = true;
  }
}