import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> _data = [
    'Apple',
    'Banana',
    'Orange',
    'Mango',
    'Pineapple',
    'Grapes',
    'Watermelon',
    'Strawberry',
    'Kiwi',
    'Blueberry',
  ];

  List<String> _filteredData = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredData.addAll(_data);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();
    List<String> filteredList = _data
        .where((item) => item.toLowerCase().contains(query))
        .toList();

    setState(() {
      _filteredData = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search...',
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _filteredData.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_filteredData[index]),
          );
        },
      ),
    );
  }
}
