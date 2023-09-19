// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_collection_literals

import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitfat/main.dart';
import 'package:fitfat/models/auth.dart';
import 'package:fitfat/screens/GoalsScreen/SetGoals.dart';
import 'package:fitfat/screens/RoughScreen/radial_progress.dart';
import 'package:fitfat/screens/widget/textWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pedometer/pedometer.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import '../DietScreen/Diet.dart';
import '../HomeScreen/home_screen.dart';
import '../TrainerScreen/FinalTrainerScreen.dart';
import '../WorkoutScreen/MainWorkoutScreen/Workout_Demo.dart';

class PedometerFunction extends StatefulWidget {
  PedometerFunction();

  @override
  State<PedometerFunction> createState() => _PedometerFunctionState();
}

class _PedometerFunctionState extends State<PedometerFunction> {
  late GoogleMapController mapController;
  late Position currentPosition;
  late Position _lastPosition;
  double _distance = 0;

  void getCurrentLocation() async {
    currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {});
  }

  final AuthService _auth = new AuthService();
  //final service = FlutterBackgroundService();
  //final email = FirebaseAuth.instance.currentUser!.email!;
  //final StepCollection = FirebaseFirestore.instance.collection('StepCounter');

  DateTime currentDateTime = DateTime.now();

  Future refresh() async {}

  void sendDataToFirebase() async {
    FirebaseFirestore.instance
        .collection('data')
        .add({'timestamp': FieldValue.serverTimestamp()});
  }

  int _selectedIndex = 99;
  double x = 0.0;
  double y = 0.0;
  double z = 0.0;
  int noofsteps = 0;
  double c = 1312.33595801;
  double kilos = 0;
  double exactDistance = 0.0;
  double previousDistance = 0.0;
  String StepGoals = '';
  String Remaining = '';

  //late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
  //bool _isListeningToAccelerometer = true;

  getCurrentDate() {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    return formattedDate;
  }

  void _getdata() async {
    FirebaseFirestore.instance
        .collection('StepGoals')
        .doc(FirebaseAuth.instance.currentUser!.email!)
        .snapshots()
        .listen((userData) {
      setState(() {
        StepGoals = userData.data()!['Set Goals'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getdata();
    getCurrentLocation();
    _getLocation();

    // if (_accelerometerSubscription != null) {
    //   _accelerometerSubscription.cancel();
    // }
    //super.dispose();
  }

  void _toggleAccelerometer() {
    // if (_isListeningToAccelerometer) {
    //   _accelerometerSubscription = SensorsPlatform.instance.accelerometerEvents
    //       .listen((AccelerometerEvent event) {
    //     noofsteps++;
    //   });
    // } else {
    //   _accelerometerSubscription.cancel();
    // }
    // setState(() {
    //   _isListeningToAccelerometer = !_isListeningToAccelerometer;
    // });
  }

  void _getLocation() async {
    Geolocator.getPositionStream().listen((Position position) {
      if (_lastPosition != null) {
        double distanceInMeters = Geolocator.distanceBetween(
          _lastPosition.latitude,
          _lastPosition.longitude,
          position.latitude,
          position.longitude,
        );
        setState(() {
          _distance += distanceInMeters;
        });
      }
      _lastPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Header = Material(
      child: Column(
        children: [
          Container(
            height: 40,
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
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Home()));
                  },
                )),
                SizedBox(width: 85),
                Container(
                  width: 135,
                  // child: Text(
                  //   '$currentDateTime',
                  //   textAlign: TextAlign.center,
                  //   style: GoogleFonts.lato(
                  //     textStyle: Theme.of(context).textTheme.headline4,
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.w900,
                  //     color: Colors.white,
                  //     letterSpacing: 1,
                  //   ),
                  // ),
                ),
                IconButton(
                  padding: const EdgeInsets.only(left: 69.0, right: 0.0),
                  icon: Icon(
                    Icons.history_sharp,
                    color: Colors.white,
                    size: 33,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );

    final PosterArea = Material(
        child: Column(
      children: [
        Container(
          height: 200,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target:
                  LatLng(currentPosition.latitude, currentPosition.longitude),
              zoom: 16.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
        ),
      ],
    )

        // child: Container(
        //   height: 250,
        //   width: 400,
        //   alignment: Alignment.center,
        //   //color: Colors.black,
        //   child: Row(
        //     children: [
        //       Container(
        //         margin: const EdgeInsets.only(top: 20.0, left: 10.0),
        //         decoration: BoxDecoration(
        //           // ignore: prefer_const_literals_to_create_immutables
        //           borderRadius: BorderRadius.circular(10),
        //           //color: Color.fromARGB(255, 92, 155, 164),
        //           color: Colors.white,
        //           boxShadow: [
        //             BoxShadow(
        //               color: Colors.black.withOpacity(0.12),
        //               blurRadius: 5.0,
        //               spreadRadius: 1.1,
        //             ),
        //           ],
        //         ),
        //         padding: const EdgeInsets.only(right: 10.0, left: 10.0),
        //         height: 250,
        //         width: 339,
        //         child: Image.asset(
        //           'assets/images/giphy.gif',
        //         ),
        //       ),
        //     ],
        //   ),
        // ),

        // child: Column(
        //   children: [
        // Container(
        //   child: GoogleMap(
        //     initialCameraPosition: CameraPosition(
        //       target: LatLng(37.7749, -122.4194),
        //       zoom: 12,
        //     ),
        //     markers: Set<Marker>.of([
        //       Marker(
        //         markerId: MarkerId('marker_1'),
        //         position: LatLng(37.7749, -122.4194),
        //         infoWindow: InfoWindow(
        //           title: 'San Francisco',
        //           snippet: 'The Golden Gate City',
        //         ),
        //       ),
        //     ]),
        //   ),
        // ),
        // ],
        //),
        );

    final PedomterArea = Material(
      child: StreamBuilder<AccelerometerEvent>(
        stream: SensorsPlatform.instance.accelerometerEvents,
        builder: (context, snapshort) {
          if (snapshort.hasData) {
            x = snapshort.data!.x;
            y = snapshort.data!.y;
            z = snapshort.data!.z;
            exactDistance = calculateMagnitude(x, y, z);
            if (exactDistance > 6) {
              // try {
              //   final StepCollection=FirebaseFirestore.instance.collection('StepCounter');
              //   final docref=StepCollection.doc(CYXoe3htdpMKWfmPpz5w);

              //   docref.update({"Steps":noofsteps});
              // } catch (e) {
              noofsteps++;

              Save();
            }
          }
          return Center(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Text(
                    noofsteps.toString() + " Steps ",
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          );
        },
      ),
    );

    final SetProgressBar = Material(
        // child: CircularProgressIndicator(
        //   backgroundColor: Colors.pinkAccent,
        //   valueColor: AlwaysStoppedAnimation(Colors.black),
        //   strokeWidth: 10,
        // ),
        );

    final CaloriesCounter = Material();

    final KilometerCounter = Material();

    final Goals = Material(
      child: Row(
        children: [
          SizedBox(
            height: 40,
            width: 55,
          ),
          Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      alignment: Alignment.center,
                      child: Text(
                        '${_distance.toStringAsFixed(1)}',
                        //kilos.toStringAsFixed(2),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      //margin: EdgeInsets.all(100.0),
                      decoration: BoxDecoration(
                          color: Colors.red.shade400, shape: BoxShape.circle),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Meters",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 15),
                ),
              )
            ],
          ),
          SizedBox(
            height: 40,
            width: 100,
          ),
          Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      alignment: Alignment.center,
                      child: Text(
                        StepGoals,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      //margin: EdgeInsets.all(100.0),
                      decoration: BoxDecoration(
                          color: Colors.red.shade400, shape: BoxShape.circle),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Goal Steps",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 15),
                ),
              )
            ],
          ),
        ],
      ),
    );

    final SetGoalssss = Material(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            // ignore: unnecessary_new
            child: new GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => SetGoals()));
              },
              child: Container(
                height: 50,
                width: 200,
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 6.0),
                decoration: BoxDecoration(
                    // ignore: prefer_const_literals_to_create_immutables
                    gradient: LinearGradient(
                        colors: [Colors.orangeAccent, Colors.pinkAccent]),
                    borderRadius: BorderRadius.circular(25.0)),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Set Goals',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
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
            margin: const EdgeInsets.only(left: 0.0, right: 28.0),
            //padding: const EdgeInsets.only(left: 20.0, right: 0.0),
            alignment: Alignment.center,
            child: InkWell(
                child: Container(
                  child: ProfilePicture(
                    name: FirebaseAuth.instance.currentUser!.email!,
                    radius: 16,
                    fontsize: 15,
                    random: false,
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
            margin: const EdgeInsets.only(left: 25.0, right: 0.0),
            //padding: const EdgeInsets.only(left: 20.0, right: 0.0),
            alignment: Alignment.center,
            child: Text(
              'PEDOMETER',
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
                    PosterArea,
                    //ElevatedButton(onPressed: dispose, child: Text('MK')),
                    PedomterArea,
                    SetProgressBar,
                    CaloriesCounter,
                    KilometerCounter,
                    Goals,
                    SetGoalssss,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double calculateMagnitude(double x, double y, double z) {
    double distance = sqrt(x * x + y * y + z * z);
    getPreviousValue();
    double mode = distance - previousDistance;
    setprefData(distance);
    return mode;
  }

  void setprefData(double predistance) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setDouble("previousDistance", predistance);
  }

  void getPreviousValue() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      previousDistance = _pref.getDouble("previousDistance") ?? 0;
    });
  }

  Future<void> AddPedometer() async {
    final QuerySnapshot emailchk = await FirebaseFirestore.instance
        .collection('Pedometer')
        .where('Email', isEqualTo: FirebaseAuth.instance.currentUser!.email!)
        .get();

    final QuerySnapshot datechk = await FirebaseFirestore.instance
        .collection('Pedometer')
        .where('Date', isEqualTo: getCurrentDate())
        .get();

    final List<DocumentSnapshot> emaildocuments = emailchk.docs;
    final List<DocumentSnapshot> datedocuments = datechk.docs;

    if (emaildocuments.length > 0 && datedocuments.length > 0) {
      Map<String, String> dataToSave = {
        'Email': FirebaseAuth.instance.currentUser!.email!,
        'NoOfSteps': noofsteps.toString(),
        'Date': getCurrentDate(),
        'Kilo Meters': kilos.toStringAsFixed(2),
      };
      FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.email!)
          .doc(getCurrentDate())
          .update(dataToSave);
      print('Exist');
    } else {
      Map<String, String> dataToSave = {
        'Email': FirebaseAuth.instance.currentUser!.email!,
        'NoOfSteps': noofsteps.toString(),
        'Date': getCurrentDate(),
        'Kilo Meters': kilos.toStringAsFixed(2),
      };
      FirebaseFirestore.instance.collection('Pedometer').doc().set(dataToSave);
      print('NotExist');
    }
  }

  Future<void> Save() async {
    kilos = noofsteps / c;
    var docname = getCurrentDate().toString();
    CollectionReference users = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.email! + 'Pedometer');
    // Call the user's CollectionReference to add a new user
    await users.doc(docname).set({
      'Email': FirebaseAuth.instance.currentUser!.email!,
      'NoOfSteps': noofsteps.toString(),
      'Date': getCurrentDate(),
      'Kilo Meters': kilos.toStringAsFixed(2),
    });
    print('Save Data');
  }
}
