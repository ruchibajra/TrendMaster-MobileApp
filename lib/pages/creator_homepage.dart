import 'package:flutter/material.dart';

class CreatorHomePage extends StatefulWidget {
  @override
  _CreatorHomePageState createState() => _CreatorHomePageState();
}

class _CreatorHomePageState extends State<CreatorHomePage> {
  int currentIndex = 0;
  final PageController _pageController = PageController();
  final List<String> images = [
    'assets/images/home.png',
    'assets/images/cocacola.png',
    'assets/images/sumsung.png',
    // Add more images as needed
    // Add more image paths as needed
  ];

  final List<String> productNames = [
    'Johnsons Baby Cream',
    'Coca-Cola',
    'Samsung Phone',
    // Add more product names as needed
  ];

  final List<String> distributors = [
    'by Magnum Distributors!',
    'by Coca-Cola Company',
    'by Samsung Electronics',
    // Add more distributor names as needed
  ];

  final List<String> prices = [
    'Rs. 700/- Only',
    'Rs. 2.50/- per can',
    'Rs. 20,000/- Only',
    // Add more prices as needed
  ];

  final List<String> viewDescriptions = [
    'For 1000 Views',
    'For 5000 Views',
    'For 2000 Views',
    // Add more view descriptions as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Add the hamburger icon to open the drawer
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            color: Colors.white, // Set the color to white
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Column(
              children: [
                // Container for profile name and location
                Container(
                  color: Colors.teal,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/images/companyProfile.png'),
                      ),
                      SizedBox(width: 10, height: 200,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Khusbu Jaiswal',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 16,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Bhaktapur',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Add space between the two containers
                SizedBox(height: 20),

                // Container for list icons and names
                Container(
                  // color: Colors.white, // You can use any color you prefer
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.person, size: 30, color: Colors.grey),
                        title: Text('Profile', style: TextStyle(color: Colors.black)),
                        onTap: () {
                          // Add your navigation logic here
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.home, size: 30, color: Colors.grey),
                        title: Text('Home', style: TextStyle(color: Colors.black)),
                        onTap: () {
                          // Add your navigation logic here
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.menu_book, size: 30, color: Colors.grey),
                        title: Text('explore', style: TextStyle(color: Colors.black)),
                        onTap: () {
                          // Add your navigation logic here
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.notifications, size: 30, color: Colors.grey),
                        title: Text('Notifications', style: TextStyle(color: Colors.black)),
                        onTap: () {
                          // Add your navigation logic here
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.logout, size: 30, color: Colors.grey),
                        title: Text('logout', style: TextStyle(color: Colors.black)),
                        onTap: () {
                          // Show logout confirmation dialog
                          _showLogoutPopup(context);
                        },
                      ),

                    ],
                  ),
                ),
              ],
            )




          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 0, top: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 350,
              width: 400,
              child: PageView.builder(
                controller: _pageController,
                itemCount: images.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      double value = 1.0;
                      if (_pageController.position.haveDimensions) {
                        value = _pageController.page! - index;
                        value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
                      }
                      return Center(
                        child: SizedBox(
                          height: Curves.easeInOut.transform(value) * 300,
                          width: Curves.easeInOut.transform(value) * 300,
                          child: child,
                        ),
                      );
                    },
                    child: Image.asset(images[index]),
                  );
                },
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  productNames[currentIndex],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  distributors[currentIndex],
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  prices[currentIndex],
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 0),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  viewDescriptions[currentIndex],
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.share,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Share',
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 155,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.teal, // Set the background color to teal
                    ),
                    child: Center(
                      child: Text(
                        "View Campaign",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  // Function to show logout confirmation dialog in the center
  void _showLogoutPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Are you sure you want to logout?',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal, // Teal color for the "Yes" button
                      ),
                      onPressed: () {
                        // Add your logout logic here
                        Navigator.of(context).pop();
                      },
                      child: Text('Yes', style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal, // Teal color for the "No" button
                      ),
                      onPressed: () {
                        // Cancel the logout action
                        Navigator.of(context).pop();
                      },
                      child: Text('No', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
