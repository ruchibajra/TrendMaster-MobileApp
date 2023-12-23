import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trendmasterass2/model/campaign_model.dart';
import 'package:trendmasterass2/pages/company_budget.dart';

import 'login_page.dart';

class AddDetailsPage extends StatefulWidget {
  @override
  _AddDetailsPageState createState() => _AddDetailsPageState();
}

class _AddDetailsPageState extends State<AddDetailsPage> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController budgetController = TextEditingController();
  TextEditingController creatorNoController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<String> selectedNiches = [];

  List<Map<String, dynamic>> getNicheList() {
    return [
      {'niche': 'Fashion', 'color': Colors.teal},
      {'niche': 'Motivate', 'color': Colors.teal},
      {'niche': 'Food Vlog', 'color': Colors.teal},
      {'niche': 'Entertainment', 'color': Colors.teal},
      {'niche': 'Informative', 'color': Colors.teal},
      {'niche': 'Makeup', 'color': Colors.teal},
      {'niche': 'Content Creator', 'color': Colors.teal},
      {'niche': 'Model', 'color': Colors.teal},
      {'niche': 'Comedy', 'color': Colors.teal},
    ];
  }

  postDetailsToFirestore() async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    CampaignModel campaignModel = CampaignModel(
      id: '1',
      title: titleController.text,

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Add Details"),
        centerTitle: true, // Center the title
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Description Section
              Text(
                'Great! We need a few details about your campaign',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 25),

              //Cover Photo Section
              Text(
                'Add a cover photo*',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),

              //Upload Photo Section
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 10),

              //Campaign Title Section
              Text(
                'Campaign Title*',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),

              // Campaign Title Input Section
              Container(
                height: 40,
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                    isDense: true,
                  ),
                ),
              ),
              SizedBox(height: 10),

              //Campaign Description Section
              Text(
                'Campaign Description*',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),

              // Campaign Description Input Section
              Container(
                child: TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2),
                    ),
                    contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                    isDense: true,
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Select Niche Section
              Text(
                'Select Niche*',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: getNicheList().map((location) {
                      return OutlinedButton(
                        onPressed: () {
                          setState(() {
                            selectedNiches.contains(location['niche'])
                                ? selectedNiches.remove(location['niche'])
                                : selectedNiches.add(location['niche']);
                          });
                        },
                        child: Text(
                          location['niche'],
                          style: TextStyle(
                            color: selectedNiches.contains(location['niche']) ? Colors.white : location['color'],
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          primary: selectedNiches.contains(location['niche']) ? location['color'] : null,
                          backgroundColor: selectedNiches.contains(location['niche']) ? location['color'] : null,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),

              SizedBox(height: 35),
              Center(
                child: FractionallySizedBox(
                  widthFactor: 0.55, // Adjust this value according to your requirement
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Budget()),
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
                    child: Text("Continue"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
