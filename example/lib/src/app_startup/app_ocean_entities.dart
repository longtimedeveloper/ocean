import 'package:ocean/ocean.dart';
import '../src.dart';

class AppOceanEntities {
  AppOceanEntities();

  void setup() {
    SharedStringCasingChecks.instance.loadDefaultChecks();
    ApplicationSettingsBusinessObjectBuilder().bootstrapType();
    DemoBusinessObjectBuilder().bootstrapType();
    SignInBusinessObjectBuilder().bootstrapType();
    UserRegistrationBusinessObjectBuilder().bootstrapType();
  }
}
