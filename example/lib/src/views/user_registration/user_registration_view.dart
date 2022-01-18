import 'package:flutter/material.dart';
import 'package:ocean/ocean.dart';
import '../../src.dart';

class UserRegistrationView extends StatefulWidget {
  const UserRegistrationView._({Key? key, required this.userRegistrationViewmodel}) : super(key: key);

  factory UserRegistrationView.create({Key? key}) {
    final vm = locator<UserRegistrationViewmodel>();
    return UserRegistrationView._(key: key, userRegistrationViewmodel: vm);
  }

  final UserRegistrationViewmodel userRegistrationViewmodel;

  @override
  _UserRegistrationViewState createState() => _UserRegistrationViewState();
}

class _UserRegistrationViewState extends State<UserRegistrationView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final UserRegistration userRegistration;
  late final UserRegistrationViewmodel vm;

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  @override
  void initState() {
    vm = widget.userRegistrationViewmodel;
    userRegistration = vm.getUserRegistration();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(vm.viewTitle),
        actions: [
          CommandTextButton(
            parentFormKey: formKey,
            command: vm.saveCommand,
            buttonText: ButtonLabelConstants.save,
            buttonTextColor: Colors.white,
            fontSize: 18,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              OceanTextFormField(
                propertyName: UserRegistration.userNamePropertyName,
                businessObjectBase: userRegistration,
                propertySetter: (value) => userRegistration.userName = value,
                propertyGetter: () => userRegistration.userName,
              ),
              OceanPasswordFormField(
                propertyName: UserRegistration.passwordPropertyName,
                businessObjectBase: userRegistration,
                propertySetter: (value) => userRegistration.password = value,
                propertyGetter: () => userRegistration.password,
                goldStandardForPasswordLength: NumericConstant.goldStandardForPasswordLength,
                allowedSpecialCharacters: StringConstants.allowedSpecialCharacters,
              ),
              OceanCheckboxFormField(
                propertyName: UserRegistration.acknowledgeTermsPropertyName,
                businessObjectBase: userRegistration,
                propertySetter: (value) => userRegistration.acknowledgeTerms = value,
                propertyGetter: () => userRegistration.acknowledgeTerms,
                secondary: const Icon(Icons.app_registration),
                controlAffinity: ListTileControlAffinity.leading,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
