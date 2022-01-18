import 'package:flutter/material.dart';
import 'package:ocean/ocean.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../src.dart';

class SignInView extends StatefulWidget {
  const SignInView._({Key? key, required this.signInViewmodel}) : super(key: key);

  factory SignInView.create({Key? key}) {
    final vm = locator<SignInViewmodel>();
    return SignInView._(key: key, signInViewmodel: vm);
  }

  final SignInViewmodel signInViewmodel;

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final SignIn signIn;
  late final SignInViewmodel vm;

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  @override
  void initState() {
    vm = widget.signInViewmodel;
    signIn = vm.getSignIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Image(
                          height: 72,
                          width: 72,
                          image: AssetImage(ImageAssetConstants.oceanIcon),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          vm.viewTitle,
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    const Text('Sign In', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.blue)),
                    OceanTextFormField(
                      propertyName: SignIn.emailPropertyName,
                      businessObjectBase: signIn,
                      propertySetter: (value) => signIn.email = value,
                      propertyGetter: () => signIn.email,
                    ),
                    OceanTextFormField(
                      propertyName: SignIn.passwordPropertyName,
                      businessObjectBase: signIn,
                      propertySetter: (value) => signIn.password = value,
                      propertyGetter: () => signIn.password,
                      obscureText: true,
                      showHideShowTextButton: true,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CommandTextButtonAlwaysEnabled(
                        parentFormKey: formKey,
                        command: vm.forgotPasswordCommand,
                        buttonText: 'Forgot Password?',
                        buttonTextColor: null,
                        fontSize: 12,
                      ),
                    ),
                    CommandOutlineButton(
                      parentFormKey: formKey,
                      command: vm.signInCommand,
                      buttonText: 'Sign In',
                      style: TextButton.styleFrom(
                        minimumSize: const Size(double.infinity, 42),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CommandIconButtonAlwaysEnabled(
                          parentFormKey: formKey,
                          command: vm.signInWithGoogleCommand,
                          icon: const Icon(FontAwesomeIcons.google, color: Colors.white, size: 24),
                          iconSize: 18,
                          shape: const CircleBorder(),
                          backgroundColor: Colors.red,
                        ),
                        CommandIconButtonAlwaysEnabled(
                          parentFormKey: formKey,
                          command: vm.signInWithTwitterCommand,
                          icon: const Icon(FontAwesomeIcons.twitter, color: Colors.white, size: 24),
                          iconSize: 18,
                          shape: const CircleBorder(),
                          backgroundColor: Colors.blue,
                        ),
                        CommandIconButtonAlwaysEnabled(
                          parentFormKey: formKey,
                          command: vm.signInWithFacebookCommand,
                          icon: const Icon(FontAwesomeIcons.facebookF, color: Colors.white, size: 24),
                          iconSize: 24,
                          shape: const CircleBorder(),
                          backgroundColor: Colors.blue[800],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        CommandTextButtonAlwaysEnabled(
                          parentFormKey: formKey,
                          command: vm.registerCommand,
                          buttonText: 'Register',
                          buttonTextColor: null,
                          fontSize: 12,
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
