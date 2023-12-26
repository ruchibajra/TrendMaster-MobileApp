import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../model/campaign_model.dart';
import 'company_location.dart';

class Budget extends StatefulWidget {
  final CampaignModel campaignModel;
  Budget({required this.campaignModel});

  @override
  _BudgetState createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  TextEditingController budgetController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  int count = 0;
  void increment() {
    setState(() {
      count++;
      updateCountInFirebase(); // Debounce the update call
    });
  }

  void decrement() {
    if (count > 0) {
      setState(() {
        count--;
        updateCountInFirebase();
      });
    }
  }

  void updateCountInFirebase() {
    // Update count in Firebase Firestore
    FirebaseFirestore.instance
        .collection('counters')
        .doc('your_document_id')
        .update({'count': count});
  }

  postDetailsToFirestore() async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    CampaignModel campaignModel = CampaignModel(
      id: '1',
      title: widget.campaignModel.title ,
      description: widget.campaignModel.description,
      niche: widget.campaignModel.niche,
      image: widget.campaignModel.image,
      budget: budgetController.text,
      count: count,
    );
    // await firebaseFirestore
    //     .collection("campaign_details")
    //     .doc(user?.uid)
    //     .set(campaignModel.toMap());

    Fluttertoast.showToast(msg: "You are almost there");

    Navigator.of(context).push(
      MaterialPageRoute(builder:(context) => CompanyLocationPage(campaignModel:campaignModel)),
    );
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
        title: Text(
          'Add Budget',
          // 'Campaign Title: ${widget.campaignModel.title}',
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
                        child: NumberCounter(
                          count: count,
                          increment: increment,
                          decrement: decrement,
                        ),
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
                        controller: budgetController,
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
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async{
                              await postDetailsToFirestore();

                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.teal,
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

class NumberCounter extends StatelessWidget {
  final int count;
  final VoidCallback increment;
  final VoidCallback decrement;

  NumberCounter({
    required this.count,
    required this.increment,
    required this.decrement,
  });

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
