import 'package:flutter/material.dart';
import 'package:travelling_geeks_latest/features/calender.dart';
import 'package:travelling_geeks_latest/features/map.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('Travelling Geeks'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                _showCalendarDialog(context);
              },
              icon: Icon(Icons.calendar_month_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Destination Field
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search Destination',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Google Maps Placeholder Container (UI only)
              Container(
                height: 180,
                child: MapScreen(), // Placeholder for Google Maps
              ),

              SizedBox(height: 20),

              // Top Recommendations (Scrollable Horizontal Cards)
              Text(
                'Top Recommendations',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    RecommendationCard(),
                    RecommendationCard(),
                    RecommendationCard(),
                    RecommendationCard(),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Book Flights Button
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to flight booking page
                },
                icon: Icon(Icons.flight_takeoff),
                label: Text('Book Flights'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 20),

              // Calendar Option Button
              ElevatedButton.icon(
                onPressed: () {
                  _showCalendarDialog(context);
                },
                icon: Icon(Icons.calendar_today),
                label: Text('Choose Travel Dates'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Theme.of(context).primaryColor,
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
              maxHeight: MediaQuery.of(context).size.height * 0.8, // Constraining the height of the dialog
            ),
            child: Column(
              children: [
                // Title for the dialog
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Select Travel Dates',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),

                // Calendar view
                Expanded(
                  child: SingleChildScrollView(
                    child: CalenderScreen(), // Embedding the calendar widget
                  ),
                ),

                // Close Button
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

// Widget for recommendation cards
class RecommendationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          'Empty Card',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
