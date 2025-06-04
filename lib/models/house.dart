// models/house.dart
class House {
  // Unique identifier for each house
  final String id;
  // Property name/title
  final String name;
  // Property price formatted as string
  final String price;
  // Primary property image URL
  final String imageUrl;
  // Property location information
  final String location;
  // Number of bedrooms
  final int bedrooms;
  // Number of bathrooms
  final int bathrooms;
  // Total area in square feet
  final String area;
  // Detailed property description
  final String description;
  // Additional property images for gallery
  final List<String> additionalImages;

  House({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.location,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.description,
    required this.additionalImages,
  });
}

// Sample data repository for demonstration
class HouseRepository {
  // Static method to get sample house data
  static List<House> getSampleHouses() {
    return [
      House(
        id: '1',
        name: 'The Tatu Villa',
        price: '\$2,500,000',
        imageUrl: 'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        location: 'Karen, NAIROBI',
        bedrooms: 5,
        bathrooms: 4,
        area: '4,200 sq ft',
        description: 'Stunning modern villa with panoramic city views, featuring state-of-the-art amenities and luxurious finishes throughout.',
        additionalImages: [
          'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1600607687644-aac4c3eac7f4?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        ],
      ),
      House(
        id: '2',
        name: 'The Killimani Residence',
        price: '\$1,800,000',
        imageUrl: 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        location: 'Killimani, NAIROBI',
        bedrooms: 4,
        bathrooms: 3,
        area: '3,500 sq ft',
        description: 'The Ellora Residence blends modern elegance and comfort, offering premium living spaces with top-tier amenities and scenic surroundings.',
        additionalImages: [
          'https://images.unsplash.com/photo-1600566753086-00f18fb6b3ea?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1600566752355-35792bedcad0?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        ],
      ),
      House(
        id: '3',
        name: 'Karen Luxury Estate',
        price: '\$3,200,000',
        imageUrl: 'https://images.unsplash.com/photo-1600607687920-4e2a09cf159d?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        location: 'Karen, NAIROBI',
        bedrooms: 6,
        bathrooms: 5,
        area: '5,800 sq ft',
        description: 'Exquisite oceanfront estate featuring contemporary architecture with floor-to-ceiling windows and premium outdoor living spaces.',
        additionalImages: [
          'https://images.unsplash.com/photo-1600566752734-696cf5da25ce?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1600566753151-384129cf4e3e?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        ],
      ),
      House(
        id: '4',
        name: 'The Urban Oasis',
        price: '\$1,450,000',
        imageUrl: 'https://images.unsplash.com/photo-1600566752355-35792bedcad0?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        location: 'Eastate, NAIROBI',
        bedrooms: 4,
        bathrooms: 3,
        area: '3,100 sq ft',
        description: 'Sophisticated urban residence with clean lines, open floor plans, and integrated smart home technology.',
        additionalImages: [
          'https://images.unsplash.com/photo-1600566753086-00f18fb6b3ea?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1600566752734-696cf5da25ce?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        ],
      ),
    ];
  }
}