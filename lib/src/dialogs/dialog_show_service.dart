import 'dialogs.dart';

abstract class DialogShowService {
  Future<DialogReponse> showAppDialog(DialogRequest dialogRequest);
}
