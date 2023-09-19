import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitfat/screens/GenderScreen/SelectGender.dart';
import 'package:fitfat/screens/HomeScreen/home_screen.dart';
import 'package:fitfat/screens/ProfileScreen/Profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SetBMIAgain extends StatefulWidget {
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<SetBMIAgain> {
  double height = 170.0;
  double weight = 60.0;
  double bmi = 0;
  String Weightno = '';
  String Heightno = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 0.0, right: 0.0),
            child: IconButton(
                alignment: Alignment.topLeft,
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black54,
                  size: 33,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
                }),
          ),
          Container(
            margin: const EdgeInsets.only(left: 0.0, right: 110.0),
            padding: const EdgeInsets.only(left: 87.0, right: 0.0),
            alignment: Alignment.center,
            child: Text(
              'FIT FAT BMI',
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              )),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        //centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: Image.asset(
                'assets/images/Lovepik_com-401552168-gym-exercise.png',
                height: 200,
                width: 300),
          ),
          // ignore: prefer_const_constructors
          Padding(
            padding: const EdgeInsets.all(16.0),
            // ignore: prefer_const_constructors
            child: Text(
              "Height (cm)",
              // ignore: prefer_const_constructors
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          Slider(
            value: height,
            min: 120.0,
            max: 220.0,
            divisions: 100,
            onChanged: (newValue) {
              setState(() {
                height = newValue;
                Heightno = newValue.toString();
              });
            },
          ),
          Container(
            child: Text(
              Heightno.toString(),
              // ignore: prefer_const_constructors
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.red,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Weight (kg)",
              // ignore: prefer_const_constructors
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          Slider(
            value: weight,
            min: 20.0,
            max: 120.0,
            divisions: 100,
            onChanged: (newValue) {
              setState(() {
                weight = newValue;
                Weightno = newValue.toString();
              });
            },
          ),
          Container(
            child: Text(
              Weightno.toString(),
              // ignore: prefer_const_constructors
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.red,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              child: Text(
                "Your BMI: ${bmi.toStringAsFixed(2)}",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 20.0, left: 0),
            width: 400.0,
            child: FloatingActionButton.extended(
              label: Text('SUBMIT'),
              elevation: 0, // <-- Text
              //backgroundColor: Colors.black.withOpacity(0.5),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.grey, width: 0.5, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(50)),

              extendedTextStyle: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 20,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
              ),
              // icon: Icon(
              //   // <-- Icon
              //   Icons.forward,
              //   color: Colors.black,
              //   size: 24.0,
              // ),
              onPressed: () async {
                var docname = FirebaseAuth.instance.currentUser!.email!;
                CollectionReference users =
                    FirebaseFirestore.instance.collection('BMI');
                // Call the user's CollectionReference to add a new user
                await users.doc(docname).set({
                  'Email': FirebaseAuth.instance.currentUser!.email!,
                  'BMI': bmi,
                  'Weight': weight,
                  'Height': height
                });
                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Home()));
              },
              heroTag: BoxShadow(
                color: Colors.blue,
                spreadRadius: 7,
                blurRadius: 7,
                offset: Offset(3, 5),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            bmi = weight / ((height / 100) * (height / 100));
          });
        },
        child: Icon(Icons.boy_outlined),
      ),
    );
  }
}
