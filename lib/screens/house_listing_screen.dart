// screens/house_listing_screen.dart
import 'package:flutter/material.dart';
import '../models/house.dart';
import '../widgets/house_list_item.dart';

class HouseListingScreen extends StatefulWidget {
  const HouseListingScreen({super.key});

  @override
  State<HouseListingScreen> createState() => _HouseListingScreenState();
}

class _HouseListingScreenState extends State<HouseListingScreen> {
  // Store filtered houses based on search or filter criteria
  List<House> filteredHouses = [];
  // Text controller for search functionality
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize with all available houses from repository
    filteredHouses = HouseRepository.getSampleHouses();
  }

  @override
  void dispose() {
    // Clean up text controller to prevent memory leaks
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Search functionality section
          _buildSearchSection(),
          // Expandable list of all properties
          Expanded(child: _buildHouseList()),
        ],
      ),
    );
  }

  // Construct application bar with navigation and user profile
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      // Custom back button with proper styling
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      // Application branding in center
      title: const Text(
        'VERALUX',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
      // Search and profile actions
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black),
          onPressed: () {
            // Toggle search functionality
            _showSearchDialog();
          },
        ),
        // User profile avatar
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey[300],
            child: const Icon(Icons.person, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  // Create search input section for property filtering
  Widget _buildSearchSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextField(
        controller: searchController,
        // Update filtered results as user types
        onChanged: _filterHouses,
        decoration: InputDecoration(
          hintText: 'Search properties...',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          // Clear search functionality
          suffixIcon: searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    searchController.clear();
                    _filterHouses('');
                  },
                )
              : null,
          // Rounded border styling
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xFF4A9EAF)),
          ),
          filled: true,
          fillColor: Colors.grey[50],
        ),
      ),
    );
  }

  // Display filtered list of available properties
  Widget _buildHouseList() {
    // Handle empty search results
    if (filteredHouses.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No properties found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    // Scrollable list of property items
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: filteredHouses.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: HouseListItem(house: filteredHouses[index]),
        );
      },
    );
  }

  // Filter houses based on search query input
  void _filterHouses(String query) {
    setState(() {
      if (query.isEmpty) {
        // Show all houses when search is empty
        filteredHouses = HouseRepository.getSampleHouses();
      } else {
        // Filter based on name, location, or price matching
        filteredHouses = HouseRepository.getSampleHouses()
            .where(
              (house) =>
                  house.name.toLowerCase().contains(query.toLowerCase()) ||
                  house.location.toLowerCase().contains(query.toLowerCase()) ||
                  house.price.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  // Display search dialog for mobile-friendly search experience
  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Properties'),
        content: TextField(
          controller: searchController,
          decoration: const InputDecoration(
            hintText: 'Enter search terms...',
            border: OutlineInputBorder(),
          ),
          // Auto-focus search input when dialog opens
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _filterHouses(searchController.text);
            },
            child: const Text('Search'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              searchController.clear();
              _filterHouses('');
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}
