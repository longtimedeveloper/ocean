import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:ocean/ocean.dart';

void main() {
  test('OceanBootStrapper registers required Ocean services.', () {
// arrange

// act
    OceanBootStrapper().setup();
// assert
    expect(GetIt.instance.isRegistered<SnackBarService>(), true);
    expect(GetIt.instance.isRegistered<SnackBarRegisterService>(), true);
    expect(GetIt.instance.isRegistered<SnackBarShowService>(), true);
    expect(GetIt.instance.isRegistered<SnackBarKeyService>(), true);
    expect(GetIt.instance.isRegistered<NavigatorService>(), true);
    expect(GetIt.instance.isRegistered<DialogService>(), true);
    expect(GetIt.instance.isRegistered<DialogShowService>(), true);
    expect(GetIt.instance.isRegistered<DialogRegisterService>(), true);
  });
}
