import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(PedometerApp());
}

class PedometerApp extends StatefulWidget {
  @override
  _PedometerAppState createState() => _PedometerAppState();
}

class _PedometerAppState extends State<PedometerApp> {
  int _steps = 0;
  bool _isStarted = false;
  String _stepText = '0';

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      if (_isStarted) {
        setState(() {
          _steps++;
          _stepText = _steps.toString();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pedometer App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Steps taken: $_stepText',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text(_isStarted ? 'Stop' : 'Start'),
                onPressed: () {
                  setState(() {
                    _isStarted = !_isStarted;
                    if (!_isStarted) {
                      //_steps = 0;
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
