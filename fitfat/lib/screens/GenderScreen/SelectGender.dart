import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitfat/models/Auth.dart';
import 'package:fitfat/screens/BMIScreen/BMICalculator.dart';
import 'package:fitfat/screens/WelcomeScreen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectGender extends StatefulWidget {
  SelectGender();

  @override
  State<SelectGender> createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
//   @override
  final AuthService _auth = new AuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Header = Material(
      child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              'SELECT GENDER',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25,
                letterSpacing: 1,
              ),
            ),
          ),
          SizedBox(
            height: 0,
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset('assets/images/gender.png',
                height: 300, width: 300),
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 100.0, left: 40),
                //width: 400.0,
                child: FloatingActionButton.extended(
                  label: Text('MALE'),
                  elevation: 0, // <-- Text
                  //backgroundColor: Colors.black.withOpacity(0.5),
                  backgroundColor: Colors.blue.withOpacity(0.5),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(50)),

                  extendedTextStyle: GoogleFonts.roboto(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  icon: Icon(
                    // <-- Icon
                    Icons.male,
                    color: Colors.black,
                    size: 24.0,
                  ),
                  onPressed: () async {
                    var docname = FirebaseAuth.instance.currentUser!.email!;
                    CollectionReference users =
                        FirebaseFirestore.instance.collection('Gender');
                    // Call the user's CollectionReference to add a new user
                    await users.doc(docname).set({
                      'Email': FirebaseAuth.instance.currentUser!.email!,
                      'Gender': 'Male'
                    });
                     Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BMICalculatorScreen()));
                  },
                  heroTag: BoxShadow(
                    color: Colors.blue,
                    spreadRadius: 7,
                    blurRadius: 7,
                    offset: Offset(3, 5),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 100.0, left: 55),
                //width: 400.0,
                child: FloatingActionButton.extended(
                  label: Text('FEMALE'),
                  elevation: 0, // <-- Text
                  //backgroundColor: Colors.black.withOpacity(0.5),
                  backgroundColor: Colors.pink.withOpacity(0.5),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(50)),

                  extendedTextStyle: GoogleFonts.roboto(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  icon: Icon(
                    // <-- Icon
                    Icons.female,
                    color: Colors.black,
                    size: 24.0,
                  ),
                  onPressed: () async {
                    var docname = FirebaseAuth.instance.currentUser!.email!;
                    CollectionReference users =
                        FirebaseFirestore.instance.collection('Gender');
                    // Call the user's CollectionReference to add a new user
                    await users.doc(docname).set({
                      'Email': FirebaseAuth.instance.currentUser!.email!,
                      'Gender': 'FeMale'
                    });
                     Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BMICalculatorScreen()));
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
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 0.0, left: 0),
            width: 400.0,
            child: FloatingActionButton.extended(
              label: Text('SKIP TO NEXT PROCESS'),
              elevation: 0, // <-- Text
              //backgroundColor: Colors.black.withOpacity(0.5),
              backgroundColor: Colors.red.withOpacity(0.5),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.grey, width: 0.5, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(50)),

              extendedTextStyle: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
              icon: Icon(
                // <-- Icon
                Icons.forward,
                color: Colors.black,
                size: 24.0,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BMICalculatorScreen()));
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
    );

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
                  Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => WelcomeScreen()));
                }),
          ),
          Container(
            margin: const EdgeInsets.only(left: 0.0, right: 90.0),
            padding: const EdgeInsets.only(left: 60.0, right: 0.0),
            alignment: Alignment.center,
            child: Text(
              'FIT FAT GENDER',
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
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              //child:(
              //padding: const EdgeInsets.all(16.0),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Header,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
