import 'package:flutter/material.dart';
import 'package:ocean/ocean.dart';
import '../../src.dart';

class CustomerView extends StatefulWidget {
  const CustomerView._({Key? key, required this.customerViewModel}) : super(key: key);

  factory CustomerView.create({Key? key}) {
    final vm = locator<CustomerViewmodel>();
    return CustomerView._(key: key, customerViewModel: vm);
  }

  final CustomerViewmodel customerViewModel;

  @override
  State<CustomerView> createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {
  late final Customer demo;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final CustomerViewmodel vm;

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  @override
  void initState() {
    vm = widget.customerViewModel;
    super.initState();
  }

  Future<Customer> getCustomer() async {
    demo = await vm.getCustomer();
    return demo;
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
          ValueListenableBuilder<bool>(
              valueListenable: vm.isLoadedNotifier,
              builder: (context, isLoaded, _) {
                return PopupMenuButton<String>(
                  enabled: isLoaded,
                  icon: const Icon(Icons.more_vert),
                  onSelected: vm.popupMenuItemSelected,
                  itemBuilder: (context) {
                    return vm.popupMenuItems().map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                );
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          // CRITICAL - if any property has a ComparePropertyValidator this
          // must be AutovalidateMode.always to ensure cross-property validation occurs!
          autovalidateMode: AutovalidateMode.always,
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: getCustomer(),
              builder: (context, AsyncSnapshot<Customer> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    children: const [
                      Text(
                        'Loading from service...',
                        style: TextStyle(fontSize: 28),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(child: CircularProgressIndicator()),
                    ],
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Text('Has error');
                  } else if (!snapshot.hasData) {
                    return const Text('No data');
                  }
                  return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    OceanTextFormField(
                      propertyName: Customer.firstNamePropertyName,
                      businessObjectBase: demo,
                      propertySetter: (value) => demo.firstName = value,
                      propertyGetter: () => demo.firstName,
                    ),
                    OceanTextFormField(
                      propertyName: Customer.lastNamePropertyName,
                      businessObjectBase: demo,
                      propertySetter: (value) => demo.lastName = value,
                      propertyGetter: () => demo.lastName,
                    ),
                    OceanTextFormField(
                      propertyName: Customer.emailPropertyName,
                      businessObjectBase: demo,
                      propertySetter: (value) => demo.email = value,
                      propertyGetter: () => demo.email,
                    ),
                    OceanTextFormField(
                      propertyName: Customer.cellPhonePropertyName,
                      businessObjectBase: demo,
                      propertySetter: (value) => demo.cellPhone = value,
                      propertyGetter: () => demo.cellPhone,
                    ),
                    OceanTextFormField(
                      propertyName: Customer.phonePropertyName,
                      businessObjectBase: demo,
                      propertySetter: (value) => demo.phone = value,
                      propertyGetter: () => demo.phone,
                    ),
                  ]);
                }
                return Text('State: ${snapshot.connectionState}');
              },
            ),
          ),
        ),
      ),
    );
  }
}
