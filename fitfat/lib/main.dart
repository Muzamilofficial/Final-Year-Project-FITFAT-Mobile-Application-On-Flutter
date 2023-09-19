// ignore_for_file: unused_import, prefer_const_constructors
import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';
import 'package:fitfat/screens/BMIScreen/BMICalculator.dart';
import 'package:fitfat/screens/Delete/add_student_page.dart';
import 'package:fitfat/screens/Delete/home_page.dart';
import 'package:fitfat/screens/Delete/list_student_page.dart';
import 'package:fitfat/screens/DietScreen/AddDiet.dart';
import 'package:fitfat/screens/DietScreen/Diet.dart';
import 'package:fitfat/screens/GenderScreen/SelectGender.dart';
import 'package:fitfat/screens/LoginScreen/login_screen.dart';
import 'package:fitfat/screens/PedometerScreen/LatestPedometer.dart';
import 'package:fitfat/screens/PedometerScreen/pedometer.dart';
import 'package:fitfat/screens/ProfileScreen/Profile.dart';
import 'package:fitfat/screens/RegistrationScreen/register_screen.dart';
import 'package:fitfat/screens/RoughScreen/Trainer.dart';
import 'package:fitfat/screens/RoughScreen/dietplan.dart';
import 'package:fitfat/screens/SplashScreen/splash_screen.dart';
import 'package:fitfat/screens/WelcomeScreen/welcome_screen.dart';
import 'package:fitfat/screens/WorkoutScreen/AerobicScreen/Aerobics.dart';
import 'package:fitfat/screens/WorkoutScreen/ChildposeScreen/childpose.dart';
import 'package:fitfat/screens/WorkoutScreen/CrunchesScreen/Crunches.dart';
import 'package:fitfat/screens/WorkoutScreen/LugesScreen/Lunges.dart';
import 'package:fitfat/screens/WorkoutScreen/MainWorkoutScreen/Workout_Demo.dart';
import 'package:fitfat/screens/WorkoutScreen/PushupScreen/Pushups.dart';
import 'package:fitfat/screens/WorkoutScreen/SquatsScreen/Squats.dart';
import 'package:fitfat/screens/WorkoutScreen/YogaScreen/ChildposeVideoScreen.dart';
import 'package:fitfat/screens/WorkoutScreen/YogaScreen/yoga.dart';
import 'package:fitfat/screens/mk.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pedometer/pedometer.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';
import 'models/Auth.dart';
import 'models/FirebaseUser.dart';
import 'screens/HomeScreen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIOverlays([]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.black,
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.black,
            textTheme: ButtonTextTheme.primary,
            colorScheme:
                Theme.of(context).colorScheme.copyWith(secondary: Colors.white),
          ),
          fontFamily: 'Georgia',
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ),

        home: WelcomeScreen(),
        //home: Home(),
        //home: PedometerFunction(),
        //home: YOGA(),
        //home: DietUsers(),
        //home: PedometerFunction(),
        //home: SelectGender(),
        //home: Home(),
        //home: HomePage(),
        //home: TakeWeight(),
        //home: YOGA(),
        //home: Workout(),
        //home: SplashScreen(),
        //home: Home(),
        //home: PedometerFunction(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
