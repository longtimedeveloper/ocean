import 'package:get_it/get_it.dart';
import 'package:ocean/ocean.dart';
import '../src.dart';

final locator = GetIt.instance;

class AppBootStrapper {
  AppBootStrapper();

  void setup() {
    // MUST configure the container with Ocean party services
    OceanBootStrapper().setup();

    // configure the container with application level viewmodels
    locator.registerFactory<ApplicationSettingsViewmodel>(() => ApplicationSettingsViewmodel());
    locator.registerFactory<CustomerViewmodel>(() => CustomerViewmodel());
    locator.registerFactory<DialogStressViewmodel>(() => DialogStressViewmodel());
    locator.registerFactory<SignInViewmodel>(() => SignInViewmodel());
    locator.registerFactory<UserRegistrationViewmodel>(() => UserRegistrationViewmodel());
  }
}
