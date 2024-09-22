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
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>PackupList()));
            },
            icon: Icon(Icons.pending_actions_sharp,size: 25,)),
        title: Text('Travelling Geeks',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                _showCalendarDialog(context);
              },
              icon: Icon(Icons.calendar_month_outlined,size: 25,))
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
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Container for Google Maps (Flutter Maps)
              // Container(
              //   height: 300,
              //   child: MapScreen(),
              // ),

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
                label: Text('Book Flights',),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.lightBlueAccent,
                  elevation: 2
                ),
              ),
              SizedBox(height: 20),

              //  Hotel Booking option button
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.apartment),
                label: Text('Book Hotels'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.lightBlueAccent,
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
