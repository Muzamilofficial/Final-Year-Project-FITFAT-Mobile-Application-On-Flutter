// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:developer';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitfat/models/auth.dart';
import 'package:fitfat/screens/HomeScreen/home_screen.dart';
import 'package:fitfat/screens/widget/textWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../TrainerScreen/FinalTrainerScreen.dart';
import '../WorkoutScreen/MainWorkoutScreen/Workout_Demo.dart';
import 'Diet.dart';

class AddDietPlanNew extends StatefulWidget {
  AddDietPlanNew();

  @override
  State<AddDietPlanNew> createState() => _AddDietState();
}

class _AddDietState extends State<AddDietPlanNew> {
  TimeOfDay _time = TimeOfDay.now().replacing(hour: 11, minute: 30);
  TimeOfDay _lunchtime = TimeOfDay.now().replacing(hour: 11, minute: 30);
  TimeOfDay _Dinnertime = TimeOfDay.now().replacing(hour: 11, minute: 30);
  bool iosStyle = true;

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
    });
  }

  void onlunchTimeChanged(TimeOfDay newTime) {
    setState(() {
      _lunchtime = newTime;
    });
  }

  void onDinnerTimeChanged(TimeOfDay newTime) {
    setState(() {
      _Dinnertime = newTime;
    });
  }

  final AuthService _auth = new AuthService();

  final CollectionReference _Diet =
      FirebaseFirestore.instance.collection('DietPlan');

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  getCurrentDate() {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    return formattedDate;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _selectedIndex = 99;
  String email = '';
  String BreakFast = '';
  String Lunch = '';
  String Dinners = '';
  String Error = '';

  final _Breakfastinp = TextEditingController();
  final _Lunchinp = TextEditingController();
  final _Dinnerinp = TextEditingController();

  Future refresh() async {}

  void _getdata() async {
    FirebaseFirestore.instance
        .collection('DietPlan')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .snapshots()
        .listen((userData) {
      setState(() {
        email = FirebaseAuth.instance.currentUser!.email!;
        BreakFast = userData.data()!['BreakFast'];
        Lunch = userData.data()!['Lunch'];
        Dinners = userData.data()!['Dinner'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getdata();
  }

  @override
  Widget build(BuildContext context) {
    final Header = Material(
      child: Column(
        children: [
          Container(
            height: 60,
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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => DietUsers()));
                  },
                )),
                SizedBox(width: 85),
                Container(
                  child: Text(
                    'DIET SECTION',
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
          SizedBox(
            height: 25,
          ),
          Container(
            child: Column(
              children: [
                Container(
                  child: Text(
                    'Today Diet Plan',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    final AddDietPlan = Material(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 0.0, right: 5.0, top: 30.0),
            child: Text(
              'Add Your Diet',
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.grey,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );

    final BreakfastField = TextFormField(
      controller: _Breakfastinp,
      autofocus: false,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Dinner field is required';
        }
        // Return null if the entered password is valid
        return null;
      },
      // ignore: prefer_const_constructors
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
        prefixIcon: Icon(Icons.add),
        //contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "BreakFast",
        hintStyle: (TextStyle(color: Colors.grey)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.cyan,
          ),
        ),
      ),
    );
    final LunchField = TextFormField(
      controller: _Lunchinp,
      autofocus: false,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Dinner field is required';
        }
        // Return null if the entered password is valid
        return null;
      },
      // ignore: prefer_const_constructors
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.add),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
        // contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Lunch",
        hintStyle: (TextStyle(color: Colors.grey)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.cyan),
        ),
      ),
    );
    final DinnerField = TextFormField(
      controller: _Dinnerinp,
      autofocus: false,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Dinner field is required';
        }
        // Return null if the entered password is valid
        return null;
      },
      // ignore: prefer_const_constructors
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.add),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
        // contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Dinner",
        hintStyle: (TextStyle(color: Colors.grey)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.cyan),
        ),
      ),
    );
    final AddTime = Material(
      child: Column(
        children: [
          Container(
            child: TextButton(
              onPressed: () {
                // Navigator.of(context).push(
                //   showPicker(
                //     context: context,
                //     value: _time,
                //     onChange: onTimeChanged,
                //   ),
                // );
              },
              child: Text(
                "Click To Add Breakfast Time",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Container(
            child: Text(
              _time.toString(),
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            child: TextButton(
              onPressed: () {
                // Navigator.of(context).push(
                //   showPicker(
                //     context: context,
                //     value: _lunchtime,
                //     onChange: onlunchTimeChanged,
                //   ),
                // );
              },
              child: Text(
                "Click To Add Lunch Time",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Container(
            child: Text(
              _lunchtime.toString(),
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            child: TextButton(
              onPressed: () {
                // Navigator.of(context).push(
                //   showPicker(
                //     context: context,
                //     value: _Dinnertime,
                //     onChange: onDinnerTimeChanged,
                //   ),
                // );
              },
              child: Text(
                "Click To Add Dinner Time",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Container(
            child: Text(
              _Dinnertime.toString(),
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
    final AddButton = Material(
        //elevation: 5.0,
        //borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: () async {
        
        var docname = FirebaseAuth.instance.currentUser!.email!+getCurrentDate().toString();
        CollectionReference users = FirebaseFirestore.instance
            .collection('Diet');
        // Call the user's CollectionReference to add a new user
        await users.doc(docname).set({
          'Email': FirebaseAuth.instance.currentUser!.email!,
          'Date': getCurrentDate(),
          "Breakfast": _Breakfastinp.text,
          "Lunch": _Lunchinp.text,
          "Dinner": _Dinnerinp.text,
          "BreakFast Time": _time.toString(),
          "Lunch Time": _lunchtime.toString(),
          "Dinner Time": _Dinnertime.toString()
        });
        print('Data Saved');
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => DietUsers()));
      },
      child: Container(
        height: 50,
        width: 250,
        padding: EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 6.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.orangeAccent, Colors.pinkAccent]),
            borderRadius: BorderRadius.circular(25.0)),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            'Submit',
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    ));
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
            onTap: () {},
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
                  Icons.card_travel_outlined,
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
                    AddDietPlan,
                    BreakfastField,
                    LunchField,
                    DinnerField,
                    AddTime,
                    AddButton,
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
