import 'package:flutter/material.dart';
import 'package:real_commutrade/theme/app_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            expandedHeight: 120.0,
            pinned: true,
            elevation: 1,
            shadowColor: Colors.black.withOpacity(0.1),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              // Corrected: Removed 'const' from a non-constant widget
              title: Text(
                'CommuTrade',
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: _buildHeaderBackground(context),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: AppTheme.primaryColor)),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildSectionHeader(context, 'Lecturer Announcements'),
                  const SizedBox(height: 16),
                  _buildAnnouncementCard(context),
                  const SizedBox(height: 32),
                  _buildSectionHeader(context, 'Your Updates'),
                  const SizedBox(height: 16),
                  _buildInfoCards(context),
                  const SizedBox(height: 32),
                  _buildSectionHeader(context, 'Recently Viewed', showViewAll: true),
                  const SizedBox(height: 16),
                  _buildRecentlyViewedList(context),
                  const SizedBox(height: 20), // Added padding at the bottom
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderBackground(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome back!',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppTheme.primaryColor.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncementCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        elevation: 0,
        color: AppTheme.accentColor.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: const ListTile(
          leading: Icon(Icons.campaign_rounded, color: AppTheme.accentColor),
          title: Text(
            'Placeholder Announcement Title',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('This is a placeholder for the announcement details...'),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
        ),
      ),
    );
  }

  Widget _buildInfoCards(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            child: _buildInfoCard(
              context,
              icon: Icons.chat_bubble_rounded,
              title: 'Chat Notifications',
              message: 'You have 3 new messages',
              color: AppTheme.secondaryColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildInfoCard(
              context,
              icon: Icons.lightbulb_rounded,
              title: 'Recommendations',
              message: 'New marketplace items',
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentlyViewedList(BuildContext context) {
    final List<Map<String, String>> recentItems = [
      {'title': 'Placeholder Item 1', 'image': 'https://picsum.photos/id/10/300/200'},
      {'title': 'Placeholder Item 2', 'image': 'https://picsum.photos/id/11/300/200'},
      {'title': 'Placeholder Item 3', 'image': 'https://picsum.photos/id/12/300/200'},
      {'title': 'Placeholder Item 4', 'image': 'https://picsum.photos/id/13/300/200'},
    ];

    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        itemCount: recentItems.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = recentItems[index];
          return _buildRecentItemCard(context, item);
        },
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, {bool showViewAll = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          if (showViewAll)
            TextButton(
              onPressed: () {},
              child: const Text('View All', style: TextStyle(color: AppTheme.secondaryColor)),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, {required IconData icon, required String title, required String message, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(message, style: Theme.of(context).textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentItemCard(BuildContext context, Map<String, String> item) {
    return SizedBox(
      width: 120,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                item['image']!,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item['title']!,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}