import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelling_geeks_latest/modals/theme_provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SettingsOptions(),
    );
  }
}

class SettingsOptions extends StatefulWidget {
  @override
  State<SettingsOptions> createState() => _SettingsOptionsState();
}

class _SettingsOptionsState extends State<SettingsOptions> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Theme Option
        ListTile(
          leading: const Icon(Icons.brightness_6),
          title: Text('Theme'),
          subtitle: Text('Light / Dark mode'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Navigate to theme settings or show dialog
            showDialog(
              context: context,
              builder: (context) {
                return ThemeDialog();
              },
            );
          },
        ),
        Divider(),

        // Language Option
        ListTile(
          leading: Icon(Icons.language),
          title: Text('Language'),
          subtitle: Text('Select App Language'),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Navigate to language settings or show dialog
            showDialog(
              context: context,
              builder: (context) {
                return LanguageDialog();
              },
            );
          },
        ),
        Divider(),
      ],
    );
  }
}

// Dialog for Theme selection
class ThemeDialog extends StatefulWidget {
  @override
  State<ThemeDialog> createState() => _ThemeDialogState();
}

class _ThemeDialogState extends State<ThemeDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Theme'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile(
            title: Text('Light'),
            value: ThemeMode.light,
            groupValue: ThemeMode.dark,
            onChanged: (value) {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
          RadioListTile(
            title: Text('Dark'),
            value: ThemeMode.dark,
            groupValue: ThemeMode.light,
            onChanged: (value) {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

// Dialog for Language selection
class LanguageDialog extends StatefulWidget {
  @override
  State<LanguageDialog> createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Language'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile(
            title: Text('English'),
            value: 'en',
            groupValue: 'en', // Placeholder for current language
            onChanged: (value) {
              // Handle language change
            },
          ),
          RadioListTile(
            title: Text('Spanish'),
            value: 'es',
            groupValue: 'en', // Placeholder for current language
            onChanged: (value) {
              // Handle language change
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
