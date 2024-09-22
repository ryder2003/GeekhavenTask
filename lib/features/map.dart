import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:travelling_geeks_latest/helper/marker.dart';
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  List<Marker> _markers = [];
  List<MarkerData> _markerData = [];
  LatLng? _selectedPosition;
  LatLng? _myLocation;
  LatLng? _draggedLocation;
  bool _isDragging = false;
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  bool _isSearching = false;

  //For determining current Position
  Future<Position> _determinePosition() async{
    bool serviceEnabled;
    LocationPermission permission;

    //Check if Location service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return Future.error("Location services are disabled");
    }
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error("Location Permissions are denied");
      }
    }
    if(permission == LocationPermission.deniedForever){
      return Future.error("Location Permissions are permanently denied");
    }
    return Geolocator.getCurrentPosition();
  }

  //Show current Location
  void _showCurrentLocation() async{
    try{
      Position position = await _determinePosition();
      LatLng currentLatLng = LatLng(position.latitude, position.longitude);
      _mapController.move(currentLatLng, 15.0);
      setState(() {
        _myLocation = currentLatLng;
      });
    } catch(e){
      print(e);
    }
  }

  //Adding Marker
  void _addMarker(LatLng position, String title, String description){
    setState(() {
      final markerData = MarkerData(position: position, title: title, description: description);
      _markerData.add(markerData);
      _markers.add(
        Marker(
            point: position,
            height: 80,
            width: 80,
            child: GestureDetector(
              onTap: ()=> _showMarkerInfo(markerData),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2)
                        )
                      ],
                    ),
                    child: Text(title,style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                  Icon(Icons.location_on,color: Colors.redAccent,size: 40,),
                ],
              ),
            ))
      );
    });
  }

  void _showMarkerDialog(BuildContext context, LatLng position){
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descController = TextEditingController();

    showDialog(
      context: context,
      builder: (context)=>AlertDialog(
        title: Text("Add Marker"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Title"
              ),
            ),

            TextField(
              controller: descController,
              decoration: InputDecoration(
                  labelText: "Description"
              ),
            )
          ],
        ),

        actions: [
          TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text("Cancel"),
          ),

          TextButton(
            onPressed: (){
             _addMarker(position, titleController.text, descController.text);
             Navigator.pop(context);
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  //Marker Info when tapped
  void _showMarkerInfo(MarkerData markerData){
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: Text(markerData.title),
      content: Text(markerData.description),
      actions: [
        IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.close))
      ],
    ));
  }

  //Search Functionality
  Future<void> _searchPlaces(String query) async{
    if(query.isEmpty){
      setState(() {
        _searchResults =[];
      });
      return;
    }
    final url = 'https:??nominatimap.org/search?q=$query&format=json&limit=5';
    final respone = await http.get(Uri.parse(url));
    final data = json.decode(respone.body);

    if(data.isNotEmpty){
      setState(() {
        _searchResults = data;
      });
    }
    else{
      setState(() {
        _searchResults = [];
      });
    }
  }

  //To move to specified location
  void _moveToLocation(double lat, double lon){
    LatLng location = LatLng(lat, lon);
    _mapController.move(location, 15.0);
    setState(() {
      _selectedPosition = location;
      _searchResults = [];
      _isSearching = false;
      _searchController.clear();
    });
  }

  @override
  @override
  void initState() {
    super.initState();
    _searchController.addListener((){
      _searchPlaces(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: LatLng(47.36667, 8.55),
              initialZoom: 13,
              onTap: (tapPosition,LatLng){
                setState(() {
                  _selectedPosition = LatLng;
                  _draggedLocation = _selectedPosition;
                });
              }
            ),
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              ),

              MarkerLayer(markers: _markers),
              if(_isDragging && _draggedLocation != null)
                MarkerLayer(
                    markers: [
                      Marker(
                          point: _draggedLocation!,
                          width: 80,
                          height: 80,
                          child: Icon(Icons.location_on, size: 40,color: Colors.indigo,)
                      )
                    ]
                ),

              if(_myLocation != null)
                MarkerLayer(
                    markers: [
                      Marker(
                          point: _myLocation!,
                          width: 80,
                          height: 80,
                          child: Icon(Icons.location_on, size: 40,color: Colors.green,)
                      )
                    ]
                )
            ],
          ),

          //search widget
          Positioned(
              top: 40,
              left: 15,
              right: 15,
              child: Column(
                children: [
                  SizedBox(
                    height: 55,
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Search place...",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide.none
                        ),
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: _isSearching ?
                            IconButton(onPressed: (){
                              _searchController.clear();
                              setState(() {
                                _isSearching = false;
                                _searchResults = [];
                              });
                            }, icon: Icon(Icons.clear)) : null
                      ),
                      onTap: (){
                        setState(() {
                          _isSearching = true;
                        });
                      },
                    ),
                  ),
                  if(_isSearching && _searchResults.isNotEmpty)
                    Container(
                        color: Colors.white,
                         child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _searchResults.length,
                          itemBuilder: (ctx,index){
                            final place = _searchResults[index];
                            return ListTile(
                              title: Text(place["Display Name"],),
                              onTap: (){
                                final lat = double.parse(place['lat']);
                                final lon = double.parse(place['lon']);
                                _moveToLocation(lat, lon);
                              },
                            );
                          }),
                    )
                ],
              )
          ),
          //For location button
          _isDragging == false ?
          Positioned(
            bottom: 20,
            left: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              onPressed: (){
                setState(() {
                  _isDragging = true;
                });
              },
              child: Icon(Icons.add_location),
            ),
          ) :
          Positioned(
            bottom: 20,
            left: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              onPressed: (){
                setState(() {
                  _isDragging = false;
                });
              },
              child: Icon(Icons.wrong_location),
            ),
          ),

          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.indigo,
                  onPressed: _showCurrentLocation,
                  child: Icon(Icons.location_searching_rounded),
                ),

                if(_isDragging)
                  Padding(padding: EdgeInsets.only(top: 20)),
                  FloatingActionButton(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.indigo,
                  onPressed: (){
                    if(_draggedLocation != null){
                      //For adding marker
                      _showMarkerDialog(context, _draggedLocation!);
                    }
                    _isDragging = false;
                    _draggedLocation = null;
                  },
                  child: Icon(Icons.check),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
