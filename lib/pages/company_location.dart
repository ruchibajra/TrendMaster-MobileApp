import 'package:flutter/material.dart';

class CompanyLocationPage extends StatefulWidget {
  @override
  _CompanyLocationPageState createState() => _CompanyLocationPageState();
}

class _CompanyLocationPageState extends State<CompanyLocationPage> {
  String selectedLocation = '';

  List<Map<String, dynamic>> getLocationList() {
    return [
      {'name': 'Anywhere in Nepal', 'color': Colors.teal[300]},
      {'name': 'Kathmandu', 'color': Colors.teal[300]},
      {'name': 'Lalitpur', 'color': Colors.teal[300]},
      {'name': 'Bhaktapur', 'color': Colors.teal[300]},
      {'name': 'Patan', 'color': Colors.teal[300]},
      {'name': 'Kritipur', 'color': Colors.teal[300]},
      {'name': 'Chandragiri', 'color': Colors.teal[300]},
      {'name': 'Dhading', 'color': Colors.teal[300]},
      {'name': 'Nagarkot', 'color': Colors.teal[300]},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Location"),
        centerTitle: true, // Center the title
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Descriptions
              Text(
                "Where do you want your creators to be located at?",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),

              Text(
                "This helps us to find the right creators based on location preference",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),

              // List of name of locations
              Center(
                child: Column(
                  children: getLocationList().map((location) {
                    return FractionallySizedBox(
                      widthFactor: 1.0, // This sets the width of the button to be the same as the available space.
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            selectedLocation = location['name'];
                          });
                        },
                        child: Text(location['name']),
                        style: OutlinedButton.styleFrom(
                          primary: location['name'] == selectedLocation ? Colors.white : null,
                          backgroundColor: location['name'] == selectedLocation ? location['color'] : null,
                          textStyle: TextStyle(color: location['name'] == selectedLocation ? Colors.white : null),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: 35),
              FractionallySizedBox(
                widthFactor: 0.55, // Adjust this value according to your requirement
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginPage()),
                    // );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
                  child: Text("Continue"),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.message, size: 30, color: Colors.grey),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30, color: Colors.grey),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, size: 30, color: Colors.grey),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30, color: Colors.grey),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
