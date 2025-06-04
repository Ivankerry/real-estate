// screens/house_detail_screen.dart
import 'package:flutter/material.dart';
import '../models/house.dart';

class HouseDetailScreen extends StatefulWidget {
  // House object containing complete property information
  final House house;

  const HouseDetailScreen({super.key, required this.house});

  @override
  State<HouseDetailScreen> createState() => _HouseDetailScreenState();
}

class _HouseDetailScreenState extends State<HouseDetailScreen> {
  // Track current image index for gallery navigation
  int currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Image gallery section with navigation controls
          _buildImageGallery(),
          // Property details section with expandable content
          Expanded(child: _buildPropertyDetails()),
        ],
      ),
    );
  }

  // Construct image gallery with navigation and indicator dots
  Widget _buildImageGallery() {
    // Combine main image with additional gallery images
    final allImages = [widget.house.imageUrl, ...widget.house.additionalImages];

    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Stack(
        children: [
          // Main image display with swipe navigation
          PageView.builder(
            itemCount: allImages.length,
            onPageChanged: (index) {
              setState(() {
                currentImageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.network(
                allImages[index],
                fit: BoxFit.cover,
                width: double.infinity,
                // Loading placeholder during image fetch
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Colors.grey[300],
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
                // Error handling for failed image loads
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.home, size: 80, color: Colors.grey),
                    ),
                  );
                },
              );
            },
          ),
          // Navigation back button positioned at top left
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),
          // Image indicator dots positioned at bottom center
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                allImages.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentImageIndex == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build comprehensive property details section
  Widget _buildPropertyDetails() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property title and pricing section
            _buildPropertyHeader(),
            const SizedBox(height: 20),
            // Property specifications and amenities
            _buildPropertySpecs(),
            const SizedBox(height: 20),
            // Additional property images gallery
            _buildAdditionalImages(),
            const SizedBox(height: 20),
            // Property description section
            _buildDescription(),
            const Spacer(),
            // Contact and booking action button
            _buildContactButton(),
          ],
        ),
      ),
    );
  }

  // Construct property header with title and pricing information
  Widget _buildPropertyHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Property name as primary heading
        Text(
          widget.house.name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        // Property price with currency formatting
        Text(
          widget.house.price,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF4A9EAF),
          ),
        ),
        const SizedBox(height: 8),
        // Property location with icon indicator
        Row(
          children: [
            const Icon(Icons.location_on, color: Colors.grey, size: 16),
            const SizedBox(width: 4),
            Text(
              widget.house.location,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }

  // Display property specifications in organized layout
  Widget _buildPropertySpecs() {
    return Row(
      children: [
        // Bedroom count specification
        _buildSpecItem(
          icon: Icons.bed,
          value: '${widget.house.bedrooms}',
          label: 'Beds',
        ),
        const SizedBox(width: 30),
        // Bathroom count specification
        _buildSpecItem(
          icon: Icons.bathtub,
          value: '${widget.house.bathrooms}',
          label: 'Baths',
        ),
        const SizedBox(width: 30),
        // Total area specification
        _buildSpecItem(
          icon: Icons.square_foot,
          value: widget.house.area,
          label: 'Area',
        ),
      ],
    );
  }

  // Create individual specification item with icon and text
  Widget _buildSpecItem({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF4A9EAF).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF4A9EAF), size: 20),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }

  // Display additional property images in horizontal scroll
  Widget _buildAdditionalImages() {
    if (widget.house.additionalImages.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gallery',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.house.additionalImages.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.house.additionalImages[index],
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    // Loading state for additional images
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[300],
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    },
                    // Error fallback for additional images
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image, color: Colors.grey),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Display comprehensive property description
  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          widget.house.description,
          style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.5),
        ),
      ],
    );
  }

  // Create prominent contact action button
  Widget _buildContactButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          // Simulate contact functionality
          _showContactDialog();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4A9EAF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 2,
        ),
        child: const Text(
          'Contact Agent',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Display contact options dialog for user interaction
  void _showContactDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Contact Agent'),
        content: const Text(
          'Would you like to schedule a viewing or get more information about this property?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Simulate scheduling functionality
              _showScheduleConfirmation();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A9EAF),
            ),
            child: const Text(
              'Schedule Viewing',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Show confirmation message for scheduled viewing
  void _showScheduleConfirmation() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Viewing scheduled! Agent will contact you soon.'),
        backgroundColor: Color(0xFF4A9EAF),
        duration: Duration(seconds: 3),
      ),
    );
  }
}
