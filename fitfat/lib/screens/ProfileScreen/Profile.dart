// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_is_empty, unnecessary_brace_in_string_interps, use_build_context_synchronously, iterable_contains_unrelated_type, duplicate_ignore, avoid_print, unused_element, non_constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitfat/models/auth.dart';
import 'package:fitfat/screens/YogaVideos/childpose.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../BMIScreen/SetBMIAgain.dart';
import '../DietScreen/Diet.dart';
import '../HomeScreen/home_screen.dart';
import '../TrainerScreen/FinalTrainerScreen.dart';
import '../WelcomeScreen/welcome_screen.dart';
import '../WorkoutScreen/MainWorkoutScreen/Workout_Demo.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen();

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _auth = new AuthService();

  getCurrentDate() {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    return formattedDate;
  }

  int _selectedIndex = 99;
  Future refresh() async {}

  String email = '';
  String wh = '';
  String hh = '';
  String bm = '';

  void _getdata() async {
    FirebaseFirestore.instance
        .collection('BMI')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .snapshots()
        .listen((userData) {
      setState(() {
        email = FirebaseAuth.instance.currentUser!.email!;
        wh = userData.data()!['Weight'].toString();
        hh = userData.data()!['Height'].toString();
        bm = userData.data()!['BMI'].toString();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getdata();
  }

  void sendDataToFirebase() async {
    FirebaseFirestore.instance
        .collection('data')
        .add({'timestamp': FieldValue.serverTimestamp()});
  }

  @override
  Widget build(BuildContext context) {
    final Header = Material(
      child: Column(
        children: [
          Container(
            height: 50,
            //color: Colors.red,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              // ignore: prefer_const_literals_to_create_immutables
              gradient: LinearGradient(colors: [
                // Color.fromARGB(255, 248, 119, 162),
                // Color.fromARGB(255, 241, 175, 131),
                Color.fromARGB(255, 241, 104, 150),
                Color.fromARGB(255, 253, 160, 98),
              ]),
            ),
            child: Row(
              children: [
                Container(
                    child: InkWell(
                  child:
                      Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white),
                  onTap: () {
                    //action code when clicked
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Workout()));
                  },
                )),
                SizedBox(width: 85),
                Container(
                  width: 135,
                  child: Text(
                    'Profile',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    final ProfilePic = Material(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            height: 150,
            width: 150,
            child: ProfilePicture(
              name: FirebaseAuth.instance.currentUser!.email!,
              radius: 16,
              fontsize: 15,
              random: true,
              count: 2,
              tooltip: true,
              //role: 'ADMINISTRATOR',
              img: (FirebaseAuth.instance.currentUser?.photoURL),
              //img: 'https://avatars.githubusercontent.com/u/37553901?v=4',
            ),
          ),
        ],
      ),
    );
    final MainProfile = Material(
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  height: 30,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                ),
                Container(
                  child: Text(
                    'Email',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                Container(
                  child: Text(
                    email,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  height: 100,
                ),
                Container(
                  child: Text(
                    'BMI',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                Container(
                  child: Text(
                    bm,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                ),
                Container(
                  child: Text(
                    'Weight',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                Container(
                  child: Text(
                    wh,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  height: 100,
                ),
                Container(
                  child: Text(
                    'Height',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                Container(
                  child: Text(
                    hh,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SetBMIAgain()));
              },
              child: Text('Update')),
          ElevatedButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
              );
              await GoogleSignIn().signOut();
              await _auth.signOut();
            },
            child: Text('CLICK TO LOGOUT HERE'),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 0.0, right: 28.0),
            //padding: const EdgeInsets.only(left: 20.0, right: 0.0),
            alignment: Alignment.center,
            child: InkWell(
                child: Container(
                  child: ProfilePicture(
                    name: FirebaseAuth.instance.currentUser!.email!,
                    radius: 16,
                    fontsize: 15,
                    random: true,
                    count: 2,
                    tooltip: true,
                    //role: 'ADMINISTRATOR',
                    img: (FirebaseAuth.instance.currentUser?.photoURL),
                    //img: 'https://avatars.githubusercontent.com/u/37553901?v=4',
                  ),
                ),
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => WelcomeScreen()));
                }),
          ),
          Container(
            margin: const EdgeInsets.only(left: 50.0, right: 0.0),
            //padding: const EdgeInsets.only(left: 20.0, right: 0.0),
            alignment: Alignment.center,
            child: Text(
              'WORKOUT',
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              )),
            ),
          ),
          GestureDetector(
            // When the child is tapped, show a snackbar
            onTap: () {
              print('MK');
            },
            child: Container(
              margin: const EdgeInsets.only(left: 38.0, right: 6.0),
              //padding: const EdgeInsets.only(left: 20.0, right: 0.0),
              alignment: Alignment.center,
              child: Text(
                'GET PRO',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w900,
                  textStyle: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    background: Paint()
                      ..color = Colors.lightBlue.shade300
                      ..strokeWidth = 14
                      ..strokeJoin = StrokeJoin.round
                      //..strokeCap = StrokeCap.round
                      ..style = PaintingStyle.stroke,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 0.0, right: 5.0),
            child: IconButton(
                icon: Icon(
                  Icons.notifications_none,
                  color: Colors.black54,
                  size: 33,
                ),
                onPressed: () {}),
          ),
        ],
        backgroundColor: Colors.white,
        //centerTitle: true,
      ),
      bottomNavigationBar: GNav(
          gap: 8,
          iconSize: 30,
          color: Colors.grey[800],
          backgroundColor: Colors.white,
          rippleColor: Colors.grey,
          activeColor: Colors.pinkAccent,
          haptic: true, // haptic feedback
          hoverColor: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.bubble_chart,
              text: 'Workout',
            ),
            GButton(
              icon: Icons.food_bank,
              text: 'Meal',
            ),
            GButton(
              icon: Icons.supervised_user_circle_rounded,
              text: 'Trainers',
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
              if (_selectedIndex == 0) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Home()));
                print(index);
              }
              if (_selectedIndex == 1) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Workout()));
              }
              if (_selectedIndex == 2) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => DietUsers()));
              }
              if (_selectedIndex == 3) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FinalTrainerScreen()));
              }
              print(index);
            });
          }),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(
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
                    ProfilePic,
                    MainProfile,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
