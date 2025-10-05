import 'package:flutter/material.dart';
import 'package:real_commutrade/screens/item_page.dart';
import 'package:real_commutrade/theme/app_theme.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({Key? key}) : super(key: key);

  @override
  State<MarketplacePage> createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  bool _isSearching = false;

  // Placeholder data for the marketplace items
  final List<Map<String, String>> marketplaceItems = const [
    {'title': 'Vintage Camera', 'price': 'RM 250.00', 'image': 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?q=80&w=1964&auto=format&fit=crop'},
    {'title': 'Wireless Headphones', 'price': 'RM 180.00', 'image': 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=2070&auto=format&fit=crop'},
    {'title': 'Classic Novel Set', 'price': 'RM 75.00', 'image': 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?q=80&w=1887&auto=format&fit=crop'},
    {'title': 'Potted Succulent', 'price': 'RM 35.00', 'image': 'https://images.unsplash.com/photo-1509423350716-97f9360b4e2c?q=80&w=1887&auto=format&fit=crop'},
    {'title': 'Leather Backpack', 'price': 'RM 120.00', 'image': 'https://images.unsplash.com/photo-1553062407-98eeb68c6a62?q=80&w=1887&auto=format&fit=crop'},
    {'title': 'Acoustic Guitar', 'price': 'RM 400.00', 'image': 'https://images.unsplash.com/photo-1510915361894-db8b60106945?q=80&w=2070&auto=format&fit=crop'},
    {'title': 'Running Shoes', 'price': 'RM 220.00', 'image': 'https://images.unsplash.com/photo-1460353581641-37baddab0fa2?q=80&w=2071&auto=format&fit=crop'},
    {'title': 'Smart Watch', 'price': 'RM 350.00', 'image': 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?q=80&w=1964&auto=format&fit=crop'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // No back button on a main tab
        title: _isSearching
            ? _buildSearchField()
            : const Text('Marketplace'),
        actions: <Widget>[
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () => setState(() => _isSearching = !_isSearching),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () { /* Placeholder for cart action */ },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,          // Two items per row
          crossAxisSpacing: 16.0,     // Spacing between columns
          mainAxisSpacing: 16.0,      // Spacing between rows
          childAspectRatio: 0.7,      // Adjust ratio for card height
        ),
        itemCount: marketplaceItems.length,
        itemBuilder: (context, index) {
          final item = marketplaceItems[index];
          return _buildItemCard(context, item);
        },
      ),
    );
  }

  // Widget for the search text field in the AppBar
  Widget _buildSearchField() {
    return TextField(
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Search...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 18.0),
    );
  }

  // Widget for a single item card in the grid
  Widget _buildItemCard(BuildContext context, Map<String, String> item) {
    return GestureDetector(
      onTap: () {
        // This is the link to ItemPage
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ItemPage(item: item)),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.1),
        clipBehavior: Clip.antiAlias, // Ensures the image respects the rounded corners
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Image.network(
                item['image']!,
                fit: BoxFit.cover,
                // Shows a loading indicator
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                        : null,
                  ));
                },
                // Shows an error icon if the image fails to load
                errorBuilder: (context, error, stackTrace) =>
                const Center(child: Icon(Icons.broken_image, color: Colors.grey, size: 40)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item['title']!,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    item['price']!,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}