import 'package:flutter/material.dart';
import '../../src.dart';

class DialogStressView extends StatefulWidget {
  const DialogStressView._({Key? key, required this.dialogStressViewModel}) : super(key: key);

  factory DialogStressView.create({Key? key}) {
    final vm = locator<DialogStressViewmodel>();
    return DialogStressView._(key: key, dialogStressViewModel: vm);
  }

  final DialogStressViewmodel dialogStressViewModel;

  @override
  _DialogStressViewState createState() => _DialogStressViewState();
}

class _DialogStressViewState extends State<DialogStressView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final DialogStressViewmodel vm;

  @override
  void initState() {
    vm = widget.dialogStressViewModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(vm.viewTitle),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      child: CommandElevatedButtonWithIconAlwaysEnabled(
                          parentFormKey: formKey,
                          command: vm.deleteCommand,
                          icon: const Icon(Icons.add_alarm),
                          labelText: 'Show Dialog'),
                    ),
                    Container(
                      color: Colors.black12,
                      padding: const EdgeInsets.all(20.0),
                      child: TweenAnimationBuilder<double>(
                          duration: const Duration(seconds: 10),
                          tween: Tween(begin: 0, end: 10),
                          onEnd: () {
                            vm.showStressorDialog();
                          },
                          builder: (BuildContext context, double value, Widget? child) {
                            var text = 'Dialog Requested';
                            if (value.round() < 10) {
                              text = 'Dialog Opens in\n${(value.round() - 10).abs()} seconds';
                            }
                            return Text(
                              text,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            );
                          }),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Column(
                    children: const [
                      Text(
                          'This demonstrates another widget off glass requesting a dialog, or a widget in view that requests a dialog while another dialog is in view.'),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                          'While probably not as common in a mobile application, desktop or web applications have a lot more widges on and off glass.'),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                          'Tabbed interfaces can experience this if one of the hidden tabs has a long running process (async call or an isolate) and it becomes necessary display a dialog; for example an exception was caught and it was the normal behavior of the application to show a dialog when an exception occurs.'),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                          'This dialog service relieves the developer from being concerned about two or more dialogs being called at the same time.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
