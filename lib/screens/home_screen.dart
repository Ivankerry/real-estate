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

  // Construct header section with welcome text and navigation
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Application greeting message
          const Text(
            'Exceptional',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Text(
            'Living Starts',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          // Action prompt with navigation arrow
          Row(
            children: [
              const Text(
                'Here',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              // Clickable arrow for navigation to full listings
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

  // Create featured properties section with horizontal scroll
  Widget _buildFeaturedSection(List<House> houses) {
    return SizedBox(
      height: 280,
      child: Column(
        children: [
          // Section spacing
          const SizedBox(height: 20),
          // Horizontal scrollable list of featured properties
          Expanded(
            child: ListView.builder(
              // Enable horizontal scrolling direction
              scrollDirection: Axis.horizontal,
              // Add padding to first and last items
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
