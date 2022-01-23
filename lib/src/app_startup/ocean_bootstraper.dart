import 'package:get_it/get_it.dart';
import '../dialogs/dialogs.dart';
import '../snack_bars/snack_bars.dart';
import '../navigator/navigator.dart';

class OceanBootStrapper {
  OceanBootStrapper();

  void setup() {
    // configure the container with application level services
    GetIt.instance.registerSingleton<SnackBarService>(SnackBarService());
    GetIt.instance.registerSingleton<SnackBarRegisterService>(GetIt.instance<SnackBarService>());
    GetIt.instance.registerSingleton<SnackBarShowService>(GetIt.instance<SnackBarService>());
    GetIt.instance.registerSingleton<SnackBarKeyService>(GetIt.instance<SnackBarService>());
    GetIt.instance.registerSingleton<SnackBarBuildService>(GetIt.instance<SnackBarService>());

    GetIt.instance.registerSingleton<NavigatorService>(NavigatorService());

    GetIt.instance.registerSingleton<DialogService>(DialogService(GetIt.instance<NavigatorService>()));
    GetIt.instance.registerSingleton<DialogShowService>(GetIt.instance<DialogService>());
    GetIt.instance.registerSingleton<DialogRegisterService>(GetIt.instance<DialogService>());
  }
}
