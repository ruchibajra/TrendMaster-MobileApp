import 'package:flutter/material.dart';
import 'package:trendmasterass2/pages/company_homepage.dart';
import 'package:trendmasterass2/pages/company_registration.dart';
import 'package:trendmasterass2/pages/creator_registration.dart';
import 'package:trendmasterass2/pages/login_page.dart';

class UsertypePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Options'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Choose Your Account Type',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),


            // Button One Section
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreatorRegistration(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                side: const BorderSide(
                  color: Colors.purple,
                  width: 3.0,
                ),
                padding: EdgeInsets.all(10),
              ),
              child: Container(
                width: 60,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/influencer_logo.png',
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            // Button Two Section
            const Text(
              'Creator',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CompanyRegistrationScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                side: const BorderSide(
                  color: Colors.purple,
                  width: 3.0,
                ),
                padding: EdgeInsets.all(10),
              ),
              child: Container(
                width: 60,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/company_logo.png',
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            const Text(
              'Company',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

