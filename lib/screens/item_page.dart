import 'package:flutter/material.dart';
import 'package:real_commutrade/theme/app_theme.dart';

class ItemPage extends StatefulWidget {
  final Map<String, String> item;

  const ItemPage({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  bool _isFavourited = false;
  final double _rating = 4.5;
  final int _numberOfReviews = 120;
  final List<Map<String, String>> _reviews = [
    {'user': 'Placeholder User 1', 'rating': '5.0', 'comment': 'Great product! Exactly as described.'},
    {'user': 'Placeholder User 2', 'rating': '4.0', 'comment': 'Good quality, but took a bit longer to arrive.'},
    {'user': 'Placeholder User 3', 'rating': '5.0', 'comment': 'Excellent! The seller was very responsive.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item['title']!, style: const TextStyle(color: Colors.white)),
        elevation: 1,
        shadowColor: Colors.black.withOpacity(0.1),
        actions: [
          IconButton(
            icon: Icon(
              _isFavourited ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              color: _isFavourited ? Colors.redAccent : Colors.white,
            ),
            onPressed: () {
              setState(() => _isFavourited = !_isFavourited);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_isFavourited ? 'Added to Favourites!' : 'Removed from Favourites!'),
                  duration: const Duration(milliseconds: 1500),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: _buildAddToCartBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.network(
              widget.item['image']!,
              height: 300,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) => progress == null ? child : const Center(child: CircularProgressIndicator()),
              errorBuilder: (context, error, stack) => Container(
                height: 300,
                color: Colors.grey[200],
                child: const Center(child: Icon(Icons.broken_image, color: Colors.grey, size: 50)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.item['title']!,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.item['price']!,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppTheme.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Divider(color: Colors.grey.shade300),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      _buildStarRating(_rating, size: 20),
                      const SizedBox(width: 8.0),
                      Text(
                        '$_rating ($_numberOfReviews Reviews)',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    'This is a placeholder for a detailed product description. It provides more information about the item, its features, and specifications. The text is now styled for better readability.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  Text(
                    'Customer Reviews',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16.0),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _reviews.length,
                    itemBuilder: (context, index) => ReviewCard(review: _reviews[index]),
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                  ),
                  const SizedBox(height: 24.0),

                  // Corrected OutlinedButton syntax
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppTheme.primaryColor, width: 1.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Write a review!')),
                        );
                      },
                      child: const Text('Write a Review'),
                    ),
                  ),
                  // Extra space at the bottom so the FAB doesn't cover content
                  const SizedBox(height: 90),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildAddToCartBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SizedBox(
        height: 55,
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item added to cart!')));
          },
          child: Text('Add to Cart', style: Theme.of(context).textTheme.labelLarge),
        ),
      ),
    );
  }

  // Single, correct version of _buildStarRating
  Widget _buildStarRating(double rating, {required double size}) {
    List<Widget> stars = [];
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;

    for (int i = 0; i < 5; i++) {
      IconData icon;
      if (i < fullStars) {
        icon = Icons.star_rounded;
      } else if (i == fullStars && hasHalfStar) {
        icon = Icons.star_half_rounded;
      } else {
        icon = Icons.star_border_rounded;
      }
      stars.add(Icon(icon, color: Colors.amber, size: size));
    }
    return Row(children: stars);
  }
}

// A widget to display a single review card.
class ReviewCard extends StatelessWidget {
  final Map<String, String> review;
  const ReviewCard({Key? key, required this.review}) : super(key: key);

  // Helper method for star rating within the ReviewCard
  Widget _buildStarRating(double rating, {required double size}) {
    List<Widget> stars = [];
    int fullStars = rating.floor();
    for (int i = 0; i < 5; i++) {
      stars.add(Icon(
        i < fullStars ? Icons.star_rounded : Icons.star_border_rounded,
        color: Colors.amber,
        size: size,
      ));
    }
    return Row(children: stars);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                review['user']!,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              _buildStarRating(double.parse(review['rating']!), size: 16),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            review['comment']!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}