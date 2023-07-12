import '../models/widgets/ken_model.dart';

abstract class KenWidgetInterface {
  runControllerActivities(KenModel model);
  dynamic treatData(KenModel model);
}
