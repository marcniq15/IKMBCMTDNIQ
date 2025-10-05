import 'package:flutter/material.dart'; // Corrected the import statement
import 'package:real_commutrade/screens/settings_page.dart';
import 'package:real_commutrade/theme/app_theme.dart';

// The page remains a StatelessWidget. The interactive part is handled internally.
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // We use StatefulBuilder to manage state only for the header.
            // This is a self-contained stateful part inside a stateless page.
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                // This state variable lives only inside this builder.
                bool showRoomNumber = false;

                return Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: AppTheme.primaryColor,
                      child: Icon(Icons.person, color: Colors.white, size: 60),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Placeholder User',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            // Use the provided setState to rebuild only this section.
                            setState(() {
                              showRoomNumber = !showRoomNumber;
                            });
                          },
                          // Add padding for a larger tap area
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              'ABC012345',
                              style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: showRoomNumber ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 300),
                          child: showRoomNumber
                              ? Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                              decoration: BoxDecoration(
                                color: AppTheme.secondaryColor,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: const Text(
                                'Room: A012',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 32),

            // --- The rest of the page remains the same ---
            _buildSectionTitle(context, 'Account'),
            const SizedBox(height: 12),
            _buildProfileMenuCard(context, children: [
              _buildMenuOption(icon: Icons.edit_outlined, title: 'Edit Profile', onTap: () {}),
              const Divider(indent: 56, height: 1),
              _buildMenuOption(icon: Icons.storefront_outlined, title: 'My Listings', onTap: () {}),
              const Divider(indent: 56, height: 1),
              _buildMenuOption(icon: Icons.favorite_border_rounded, title: 'My Favourites', onTap: () {}),
            ]),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Support & Info'),
            const SizedBox(height: 12),
            _buildProfileMenuCard(context, children: [
              _buildMenuOption(icon: Icons.help_outline, title: 'Help Center', onTap: () {}),
              const Divider(indent: 56, height: 1),
              _buildMenuOption(icon: Icons.info_outline, title: 'About CommuTrade', onTap: () {}),
            ]),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: Text('Sign Out', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.red)),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.withOpacity(0.1),
                foregroundColor: Colors.red,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

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

  Widget _buildProfileMenuCard(BuildContext context, {required List<Widget> children}) {
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

  Widget _buildMenuOption({required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryColor),
      title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}