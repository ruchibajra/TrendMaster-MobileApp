import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'company_location.dart';

class Budget extends StatelessWidget {
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
        title: Text(
          "Add Your Budget",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 90.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Let\'s start with your budget for this campaign.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(right: 60, top: 40),
                        child: Text(
                          'How many creators do you want?',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: NumberCounter(),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Your Budget',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 15),
                      Text(
                        'minimum budget is based on the number of creators chosen.',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 20),

                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter your budget',
                        ),
                      ),
                      SizedBox(height: 30),
                      Center(
                        child: Text(
                          'Just Few Steps Remaining',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: SizedBox(
                          width: 200, // Set the width of the button
                          height: 50, // Set the height of the button
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => CompanyLocationPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.teal, // Set the button color to teal
                            ),
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Rest of your content
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

class NumberCounter extends StatefulWidget {
  @override
  _NumberCounterState createState() => _NumberCounterState();
}

class _NumberCounterState extends State<NumberCounter> {
  int count = 0;

  void increment() {
    setState(() {
      count++;
      debounceUpdateCountInFirebase(); // Debounce the update call
    });
  }

  void decrement() {
    if (count > 0) {
      setState(() {
        count--;
        debounceUpdateCountInFirebase(); // Debounce the update call
      });
    }
  }

  void debounceUpdateCountInFirebase() {
    // Debounce the update call using a timer
    const duration = Duration(milliseconds: 500); // Adjust the duration as needed
    Timer(duration, () {
      // Update count in Firebase Firestore
      FirebaseFirestore.instance
          .collection('counters')
          .doc('your_document_id')
          .update({'count': count});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey.shade200,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: decrement,
              ),
              SizedBox(width: 10),
              Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: increment,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
