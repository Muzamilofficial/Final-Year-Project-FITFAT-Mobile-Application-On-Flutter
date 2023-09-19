import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitfat/models/Auth.dart';
import 'package:fitfat/screens/PedometerScreen/pedometer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SetGoals extends StatefulWidget {
  SetGoals();

  @override
  State<SetGoals> createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SetGoals> {
//   @override
  final AuthService _auth = new AuthService();

  final _controller = TextEditingController();

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
              'ENTER GOALS',
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
            child:
                Image.asset('assets/images/ggg.png', height: 300, width: 300),
          ),
          Column(
            children: [
              Container(
                  child: TextFormField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        // for below version 2 use this
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
// for version 2 and greater youcan also use this
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                          hintText: "Enter Goals",
                          icon: Icon(Icons.boy_outlined)))),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 0.0, left: 0),
            width: 400.0,
            child: FloatingActionButton.extended(
              label: Text('SET GOALS'),
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
              onPressed: () async {
                var docname = FirebaseAuth.instance.currentUser!.email!;
                CollectionReference users =
                    FirebaseFirestore.instance.collection('StepGoals');
                // Call the user's CollectionReference to add a new user
                await users.doc(docname).set({
                  'Email': FirebaseAuth.instance.currentUser!.email!,
                  'Set Goals': _controller.text,
                });
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
                 onPressed: () {},
                 //{Navigator.of(context).push(MaterialPageRoute(
                //                   builder: (context) => PedometerFunction()));}
                                  ),
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
