import 'package:flutter/material.dart';
import '../../example_constants.dart';
import '../views.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConstants.appTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: (1 / .4),
          shrinkWrap: true,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ApplicationSettingsView.create(),
                  ),
                );
              },
              child: const Text(
                'Settings',
                style: TextStyle(fontSize: 24),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserRegistrationView.create(),
                  ),
                );
              },
              child: const Text(
                'Registration',
                style: TextStyle(fontSize: 24),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomerView.create(),
                  ),
                );
              },
              child: const Text(
                'Customers',
                style: TextStyle(fontSize: 24),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInView.create(),
                  ),
                );
              },
              child: const Text(
                'Sign In',
                style: TextStyle(fontSize: 24),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DialogStressView.create(),
                  ),
                );
              },
              child: const Text(
                'Stress Dialog\nAPI',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
