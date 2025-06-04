// main.dart
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  // Entry point of the application
  runApp(const RealEstateApp());
}

class RealEstateApp extends StatelessWidget {
  const RealEstateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application title for device identification
      title: 'Real Estate App',
      // Disable debug banner for clean interface
      debugShowCheckedModeBanner: false,
      // Define application theme
      theme: ThemeData(
        // Set primary color scheme
        primarySwatch: Colors.blue,
        // Use Material 3 design system
        useMaterial3: true,
      ),
      // Set home screen as initial route
      home: const HomeScreen(),
    );
  }
}