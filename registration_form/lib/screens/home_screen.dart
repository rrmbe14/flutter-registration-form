import 'package:flutter/material.dart';
import 'package:registration_form/models/user_data.dart';
import 'package:registration_form/screens/registration_page1.dart';
import 'package:registration_form/widgets/user_data_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.themeMode, super.key});

  final ValueNotifier<ThemeMode> themeMode;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserData? _userData;

  Future<void> _startRegistration() async {
    final UserData? result = await Navigator.push<UserData>(
      context,
      MaterialPageRoute<UserData>(
        builder: (BuildContext context) => const RegistrationPage1(),
      ),
    );

    if (!mounted) {
      return;
    }

    if (result != null) {
      setState(() => _userData = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration App'),
        actions: <Widget>[
          ValueListenableBuilder<ThemeMode>(
            valueListenable: widget.themeMode,
            builder: (BuildContext context, ThemeMode mode, _) {
              final bool isDark = mode == ThemeMode.dark ||
                  (mode == ThemeMode.system &&
                      MediaQuery.platformBrightnessOf(context) ==
                          Brightness.dark);
              return IconButton(
                icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                tooltip:
                    isDark ? 'Switch to light mode' : 'Switch to dark mode',
                onPressed: () => widget.themeMode.value =
                    isDark ? ThemeMode.light : ThemeMode.dark,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Welcome!',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              "Let's get you registered in two quick steps.",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _startRegistration,
              child: const Text('Get Started'),
            ),
            if (_userData != null) ...<Widget>[
              const SizedBox(height: 16),
              UserDataCard(data: _userData!),
            ],
          ],
        ),
      ),
    );
  }
}
