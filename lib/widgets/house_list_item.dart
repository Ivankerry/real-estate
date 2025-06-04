// widgets/house_list_item.dart
import 'package:flutter/material.dart';
import '../models/house.dart';
import '../screens/house_detail_screen.dart';

class HouseListItem extends StatelessWidget {
  // House object containing all property details
  final House house;

  const HouseListItem({
    super.key,
    required this.house,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Handle tap to navigate to property details
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HouseDetailScreen(house: house),
          ),
        );
      },
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          // Apply card styling with rounded corners and shadow
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Property image section with fixed dimensions
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              child: Container(
                width: 120,
                height: double.infinity,
                child: Image.network(
                  house.imageUrl,
                  fit: BoxFit.cover,
                  // Loading indicator during image fetch
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  },
                  // Error fallback for failed image loads
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.home,
                        size: 30,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
            // Property information section with flexible layout
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Property name positioned at top left as specified
                    Text(
                      house.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Property location information
                    Text(
                      house.location,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Property specifications row
                    Row(
                      children: [
                        // Bedroom count with icon
                        Icon(
                          Icons.bed,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${house.bedrooms}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 15),
                        // Bathroom count with icon
                        Icon(
                          Icons.bathtub,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${house.bathrooms}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        // Flexible spacer to push price to the right
                        const Spacer(),
                        // Property price display
                        Text(
                          house.price,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4A9EAF),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}