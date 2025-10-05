import 'package:flutter/material.dart';
import 'package:real_commutrade/theme/app_theme.dart';
import 'package:real_commutrade/theme/app_theme_notifier.dart'; // 1. Import the notifier

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // We still need this for the "Notifications" switch state
  bool _isNotificationEnabled = true;

  @override
  Widget build(BuildContext context) {
    // 2. Determine the current theme state directly from the context.
    // This is more reliable than a separate state variable.
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSectionTitle(context, 'Display'),
            const SizedBox(height: 12),
            _buildSettingsCard(
              context,
              children: [
                _buildSwitchOption(
                  title: 'Dark Mode',
                  subtitle: isDarkMode ? 'Dark theme enabled' : 'Light theme enabled',
                  value: isDarkMode,
                  onChanged: (value) {
                    // 3. This is the key change!
                    // Find the notifier and call the function to change the theme.
                    AppThemeNotifier.of(context).changeTheme(value ? ThemeMode.dark : ThemeMode.light);
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),

            _buildSectionTitle(context, 'Preferences'),
            const SizedBox(height: 12),
            _buildSettingsCard(
              context,
              children: [
                _buildSwitchOption(
                  title: 'Enable Notifications',
                  subtitle: _isNotificationEnabled ? 'Notifications are ON' : 'Notifications are OFF',
                  value: _isNotificationEnabled,
                  onChanged: (value) => setState(() => _isNotificationEnabled = value),
                ),
                const Divider(indent: 16, height: 1),
                _buildNavigationOption(
                  title: 'Language',
                  currentValue: 'English',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 32),

            _buildSectionTitle(context, 'About'),
            const SizedBox(height: 12),
            _buildSettingsCard(
              context,
              children: [
                _buildNavigationOption(
                  title: 'About CommuTrade',
                  currentValue: 'v1.0.0',
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets (unchanged) ---

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title.toUpperCase(),
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Colors.grey.shade600,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildSettingsCard(BuildContext context, {required List<Widget> children}) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: children),
    );
  }

  Widget _buildSwitchOption({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.grey.shade600)),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.secondaryColor,
      ),
    );
  }

  Widget _buildNavigationOption({
    required String title,
    required String currentValue,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(currentValue, style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
      onTap: onTap,
    );
  }
}