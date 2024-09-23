import 'package:flutter/material.dart';
import 'package:travelling_geeks_latest/features/calender.dart';
import 'package:travelling_geeks_latest/features/map.dart';
import 'package:travelling_geeks_latest/features/packup_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light background color
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => PackupList()));
          },
          icon: Icon(Icons.pending_actions_sharp, size: 25),
        ),
        title: Text(
          'Travelling Geeks',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white, // White background for the app bar
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              _showCalendarDialog(context);
            },
            icon: Icon(Icons.calendar_month_outlined, size: 25, color: Colors.black),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Button to navigate to the map screen for destination search
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.lightBlueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to the map screen
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => MapScreen()));
                  },
                  icon: Icon(Icons.map, color: Colors.white),
                  label: Text('Search and Mark Destinations', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Top Recommendations Section
              Text(
                'Top Recommendations',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 220,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    RecommendationCard(
                      imageUrl: 'https://example.com/destination1.jpg',
                      title: 'Beach Resort',
                      rating: 4.5,
                    ),
                    RecommendationCard(
                      imageUrl: 'https://example.com/destination2.jpg',
                      title: 'Mountain Lodge',
                      rating: 4.7,
                    ),
                    RecommendationCard(
                      imageUrl: 'https://example.com/destination3.jpg',
                      title: 'City Hotel',
                      rating: 4.3,
                    ),
                    RecommendationCard(
                      imageUrl: 'https://example.com/destination4.jpg',
                      title: 'Forest Cabin',
                      rating: 4.8,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Book Flights Button
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to flight booking page
                },
                icon: Icon(Icons.flight_takeoff, color: Colors.white),
                label: Text('Book Flights', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.blueAccent,
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 20),

              // Book Hotels Button
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to hotel booking page
                },
                icon: Icon(Icons.hotel, color: Colors.white),
                label: Text('Book Hotels', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.greenAccent,
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to display the calendar as a dialog
  void _showCalendarDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Select Travel Dates',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: CalenderScreen(), // Embedding the calendar widget
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Widget for recommendation cards with image, title, and rating
class RecommendationCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double rating;

  RecommendationCard({
    required this.imageUrl,
    required this.title,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                // Rating
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow[700], size: 16),
                    SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
