import 'package:flutter/material.dart';
import 'package:real_commutrade/theme/app_theme.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  // --- Placeholder Data with reliable JPEG image URLs ---
  final List<Map<String, dynamic>> _stories = const [
    {'name': 'Add', 'avatar': 'add_story', 'isLive': false}, // Special case for adding a story
    {'name': 'User 1', 'avatar': 'https://picsum.photos/id/1/200', 'isLive': true},
    {'name': 'User 2', 'avatar': 'https://picsum.photos/id/2/200', 'isLive': false},
    {'name': 'User 3', 'avatar': 'https://picsum.photos/id/3/200', 'isLive': true},
    {'name': 'User 4', 'avatar': 'https://picsum.photos/id/4/200', 'isLive': false},
    {'name': 'User 5', 'avatar': 'https://picsum.photos/id/5/200', 'isLive': false},
  ];

  final List<Map<String, dynamic>> _chats = const [
    {'name': 'User 1', 'message': 'Hey, are you free for the event?', 'time': 'Now', 'avatar': 'https://picsum.photos/id/1/200', 'unread': 2},
    {'name': 'User 3', 'message': 'Awesome, see you then!', 'time': '11:30 AM', 'avatar': 'https://picsum.photos/id/3/200', 'unread': 1},
    {'name': 'User 2', 'message': 'Okay, sounds good.', 'time': 'Yesterday', 'avatar': 'https://picsum.photos/id/2/200', 'unread': 0},
    {'name': 'User 4', 'message': 'Can you send me the file?', 'time': 'Mon', 'avatar': 'https://picsum.photos/id/4/200', 'unread': 0},
    {'name': 'User 5', 'message': 'You bet! It was great.', 'time': 'Sun', 'avatar': 'https://picsum.photos/id/5/200', 'unread': 0},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // --- Stories Section ---
          _buildStoriesSection(context),

          // --- Divider ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(color: Colors.grey.shade300),
          ),

          // --- Chat List ---
          Expanded(
            child: ListView.builder(
              itemCount: _chats.length,
              padding: const EdgeInsets.only(top: 8.0),
              itemBuilder: (context, index) {
                final chat = _chats[index];
                final bool isUnread = chat['unread'] > 0;
                return _buildChatListItem(context, chat, isUnread);
              },
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget for a single chat item ---
  Widget _buildChatListItem(BuildContext context, Map<String, dynamic> chat, bool isUnread) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Open chat with ${chat['name']}')));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(chat['avatar']!),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat['name']!,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chat['message']!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isUnread ? AppTheme.primaryColor : Colors.grey.shade500,
                      fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  chat['time']!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isUnread ? AppTheme.secondaryColor : Colors.grey.shade500,
                    fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                if (isUnread) ...[
                  const SizedBox(height: 8),
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: AppTheme.secondaryColor,
                    child: Text(
                      chat['unread'].toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ] else const SizedBox(height: 28), // Placeholder for alignment
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- Widget for the horizontal stories list ---
  Widget _buildStoriesSection(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(16.0),
        itemCount: _stories.length,
        itemBuilder: (context, index) {
          final story = _stories[index];

          // Special case for the "Add Story" button
          if (story['avatar'] == 'add_story') {
            return _buildAddStoryButton();
          }

          // A container for the gradient border
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: story['isLive']
                  ? const LinearGradient(
                colors: [Colors.pinkAccent, AppTheme.accentColor],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              )
                  : null, // No gradient if not live
            ),
            child: Container(
              padding: const EdgeInsets.all(2.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(story['avatar']!),
              ),
            ),
          );
        },
      ),
    );
  }

  // --- The "Add Story" button ---
  Widget _buildAddStoryButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 35, // Match the total radius of story items
            backgroundColor: Colors.grey.shade200,
            child: const Icon(Icons.add, size: 30, color: Colors.grey),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}