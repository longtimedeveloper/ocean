import 'package:get_it/get_it.dart';
import 'package:ocean/ocean.dart';
import '../models/models.dart';

final getIt = GetIt.instance;

void bootstrap() {
  SharedStringCasingChecks.instance.loadDefaultChecks();
  DemoBusinessObjectBuilder().bootstrapType();
  UserOptionsBusinessObjectBuilder().bootstrapType();
  ApplicationSettingsBusinessObjectBuilder().bootstrapType();
}
