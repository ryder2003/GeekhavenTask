import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:travelling_geeks_latest/features/packup_card.dart';  // For JSON encoding/decoding

class PackupList extends StatefulWidget {
  const PackupList({super.key});

  @override
  State<PackupList> createState() => _PackupListState();
}

class _PackupListState extends State<PackupList> {
  final _controller = TextEditingController();
  List toPack = [];

  @override
  void initState() {
    super.initState();
    loadData();  // Load saved data when the app starts
  }

  // Save data to SharedPreferences
  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedData = jsonEncode(toPack);
    prefs.setString('toPackList', encodedData);  // Save as a string
  }

  // Load data from SharedPreferences
  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedData = prefs.getString('toPackList');

    if (encodedData != null) {
      setState(() {
        toPack = jsonDecode(encodedData);
      });
    }
  }

  void checkBoxChanged(int index) {
    setState(() {
      toPack[index][1] = !toPack[index][1];
    });
    saveData();  // Save after every change
  }

  void addNewItem() {
    setState(() {
      toPack.add([_controller.text, false]);
      _controller.clear();  // Clear text after adding
    });
    saveData();  // Save after adding a new item
  }

  void deleteItem(int index) {
    setState(() {
      toPack.removeAt(index);
    });
    saveData();  // Save after deleting an item
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text("Travel Cheklist", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      floatingActionButton: Row(
        children: [
          SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Add new Item",
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.5),
                      borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2.1),
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              addNewItem();
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: toPack.length,
        itemBuilder: (BuildContext context, index) {
          return PackupListCard(
            carryItem: toPack[index][0],
            isPacked: toPack[index][1],
            onChanged: (value) => checkBoxChanged(index),
            deleteFunction: (context) => deleteItem(index),
          );
        },
      ),
    );
  }
}
