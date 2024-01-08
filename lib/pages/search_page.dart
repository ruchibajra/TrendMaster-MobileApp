import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trendmasterass2/model/user_model.dart';
import 'package:trendmasterass2/pages/creator_profile.dart';

class SearchPage extends StatefulWidget {
  final CompanyModel companyModel;

  SearchPage({Key? key, required this.companyModel}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<UserModel> _data = [];
  List<UserModel> _filteredData = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
    _searchController.addListener(_onSearchChanged);
  }

  void fetchData() async {
    var querySnapshot = await FirebaseFirestore.instance.collection('users').get();
    setState(() {
      _data = querySnapshot.docs.map((doc) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();
    print(_searchController.text);

    List<UserModel> filteredList = _data
        .where((user) =>
    user.firstName?.toLowerCase().contains(query) == true ||
        (user.lastName != null &&
            user.lastName!.toLowerCase().contains(query)) ||
        (user.niche != null &&
            user.niche!.toLowerCase().contains(query)))
        .toList();

    print("Filtered Data: $filteredList");

    setState(() {
      _filteredData.clear();
      _filteredData.addAll(filteredList);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)), // Optional: Adjust hint color


              ),
            ),
          ],
        ),
        iconTheme: IconThemeData(color: Colors.white), // Set the color of the back arrow icon
      ),
      body: _searchController.text.isNotEmpty // Check if search query is not empty
          ? (_filteredData.isNotEmpty
          ? ListView.builder(
        itemCount: _filteredData.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InfluencerProfile(
                    companyModel: widget.companyModel,
                    userModel: _filteredData[index],
                  ),
                ),
              );
            },
            child: ListTile(
              title: Text('${_filteredData[index].firstName}'),
              subtitle: Text(
                  'Niche: ${_filteredData[index].niche ?? "Not available"}'),
            ),
          );
        },
      )
          : Container())
          : Container(),
    );
  }
}