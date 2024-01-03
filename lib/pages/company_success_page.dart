import 'package:flutter/material.dart';
import 'package:trendmasterass2/model/user_model.dart';
import 'package:trendmasterass2/pages/company_homepage.dart';

import 'login_page.dart';


class CompanySuccessPage extends StatefulWidget {
  CompanyModel companyModel;

  CompanySuccessPage({required this.companyModel});


  @override
  State<CompanySuccessPage> createState() => _CompanySuccessPageState();
}

class _CompanySuccessPageState extends State<CompanySuccessPage> {
  @override
  Widget build(BuildContext context) {

    return Material(
        child: Column(
          children: [
            Container(
              child: Image.asset(
                'assets/images/logo.png',
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 40,),

            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.teal,
              ),
              child: Center(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 80,
                ),
              ),
            ),
            Text(
              'Congratulation', style: TextStyle(fontSize: 38, color: Colors.teal , fontWeight: FontWeight.bold),
            ),
            Text('Your campaign is successfully created', style: TextStyle(fontSize: 18),),
            SizedBox(height: 5),

            SizedBox(height: 150),
            Center(
              child: FractionallySizedBox(
                widthFactor: 0.55, // Adjust this value according to your requirement
                child: ElevatedButton(

                  onPressed: () {
                    Navigator.push(
                      context,

                      MaterialPageRoute(builder: (context) => CompanyHomePage(companyModel: widget.companyModel,)),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
                  child: Text("Back"),
                ),
              ),
            ),
          ],
        )
    );
  }
}


