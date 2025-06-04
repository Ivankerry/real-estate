// screens/home_screen.dart
import 'package:flutter/material.dart';
import '../models/house.dart';
import '../widgets/featured_house_card.dart';
import '../widgets/house_list_item.dart';
import '../screens/house_listing_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve sample house data for display
    final houses = HouseRepository.getSampleHouses();

    return Scaffold(
      // Set background color to match design
      backgroundColor: const Color(0xFF4A9EAF),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top section with welcome message and navigation
            _buildHeader(context),
            // Featured property section with horizontal scrolling
            _buildFeaturedSection(houses),
            // Expandable container for property listings
            Expanded(child: _buildPropertyListings(context, houses)),
          ],
        ),
      ),
    );
  }

  // Adjust the header to reduce spacing
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0), // Reduced bottom padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Best Houses with',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Row(
            children: [
              const Text(
                'a Click',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HouseListingScreen(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Adjust the featured section to reduce spacing
  Widget _buildFeaturedSection(List<House> houses) {
    return SizedBox(
      height: 240, // Reduced height to move the section closer to the header
      child: Column(
        children: [
          // Removed or reduced the spacing here
          const SizedBox(height: 10), // Reduced spacing
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: houses.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: FeaturedHouseCard(house: houses[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Build scrollable property listings section
  Widget _buildPropertyListings(BuildContext context, List<House> houses) {
    return Container(
      // Apply rounded corner styling to match design
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Add spacing above the "Location" box
          const SizedBox(height: 5), // Adjust this value as needed
          // Section header with location and view all option
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Location',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                // Navigate to complete property listings
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HouseListingScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'See All',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4A9EAF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Vertically scrollable property listings
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: houses.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: HouseListItem(house: houses[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
