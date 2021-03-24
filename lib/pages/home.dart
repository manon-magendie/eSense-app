import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:esense_flutter/esense.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

String _deviceName = 'Unknown';
  double _voltage = -1;
  String _deviceStatus = '';
  bool sampling = false;
  String _event = '';
  String _button = 'not pressed';
  Color _statusColor = Colors.grey;

  // the name of the eSense device to connect to -- change this to your own device.
  String eSenseName = 'eSense-0508';

  @override
  void initState() {
    super.initState();
    _connectToESense();
  }

  
  Future<void> _connectToESense() async {
    bool con = false;

    // first listen to connection events before trying to connect
    // if you want to get the connection events when connecting, set up the listener BEFORE connecting...
    ESenseManager.connectionEvents.listen((event) {
      print('CONNECTION event: $event');
    
      // try to connect to the eSense device with a given name
    // bool success = await ESenseManager.connect(eSenseName);

      // when we're connected to the eSense device, we can start listening to events from it
      if (event.type == ConnectionType.connected) _listenToESenseEvents();

      setState(() {
        switch (event.type) {
          case ConnectionType.connected:
            _deviceStatus = 'connected';
            _statusColor = Colors.green;
            break;
          case ConnectionType.unknown:
            _deviceStatus = 'unknown';
            _statusColor = Colors.grey;
            break;
          case ConnectionType.disconnected:
            _deviceStatus = 'disconnected';
            _statusColor = Colors.orangeAccent;
            break;
          case ConnectionType.device_found:
            _deviceStatus = 'device found';
            _statusColor = Colors.orangeAccent;
            break;
          case ConnectionType.device_not_found:
            _deviceStatus = 'device not found';
            _statusColor = Colors.redAccent;
            break;
        }
      });
    });

    con = await ESenseManager.connect(eSenseName);

    setState(() {
      _deviceStatus = con ? 'connecting' : 'connection failed';
    });
  }

  void _listenToESenseEvents() async {
    ESenseManager.eSenseEvents.listen((event) {
      print('ESENSE event: $event');

      setState(() {
        switch (event.runtimeType) {
          case DeviceNameRead:
            _deviceName = (event as DeviceNameRead).deviceName;
            break;
          case BatteryRead:
            _voltage = (event as BatteryRead).voltage;
            break;
          case ButtonEventChanged:
            _button = (event as ButtonEventChanged).pressed ? 'pressed' : 'not pressed';
            break;
          case AccelerometerOffsetRead:
            // TODO
            break;
          case AdvertisementAndConnectionIntervalRead:
            // TODO
            break;
          case SensorConfigRead:
            // TODO
            break;
        }
      });
    });

    _getESenseProperties();
  }

  void _getESenseProperties() async {
    // get the battery level every 10 secs
    Timer.periodic(Duration(seconds: 10), (timer) async => await ESenseManager.getBatteryVoltage());

    // wait 2, 3, 4, 5, ... secs before getting the name, offset, etc.
    // it seems like the eSense BTLE interface does NOT like to get called
    // several times in a row -- hence, delays are added in the following calls
    Timer(Duration(seconds: 2), () async => await ESenseManager.getDeviceName());
    Timer(Duration(seconds: 3), () async => await ESenseManager.getAccelerometerOffset());
    Timer(Duration(seconds: 4), () async => await ESenseManager.getAdvertisementAndConnectionInterval());
    Timer(Duration(seconds: 5), () async => await ESenseManager.getSensorConfig());
  }

  StreamSubscription subscription;
  void _startListenToSensorEvents() async {
    // subscribe to sensor event from the eSense device
    subscription = ESenseManager.sensorEvents.listen((event) {
      //print('SENSOR event: $event');
      double accX = (event.accel[0] / 8192) * 9.80665;
      double accY = (event.accel[1] / 8192) * 9.80665;
      double accZ = (event.accel[2] / 8192) * 9.80665;

      double num1 = double.parse((accX).toStringAsFixed(1));
      double num2 = double.parse((accY).toStringAsFixed(1));
      double num3 = double.parse((accZ).toStringAsFixed(1));

      //print('accelerometer: ${event.accel}');
      print('accelerometer: $num1, $num2, $num3');
      setState(() {
        _event = event.toString();
      });
    });
    setState(() {
      sampling = true;
    });
  }

  void _pauseListenToSensorEvents() async {
    subscription.cancel();
    setState(() {
      sampling = false;
    });
  }

  void dispose() {
    _pauseListenToSensorEvents();
    ESenseManager.disconnect();
    super.dispose();
  }

  createAlertDialog(BuildContext context) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Connection Help'),
        content: Column(
          children: [
            Text(
              'IMPORTANT',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Only one Earbud have to be connected to your device. The second just have to be on (blue light) and it will connect automatically to the 2nd earbud.'),
            SizedBox(height: 20.0),
            Text(
              'CHECKLIST',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text('1. check the battery of the Earables. Put them in the earbud box to charge them.'),
            SizedBox(height: 5.0),
            Text('2. to connect an Earbud to your device, it must blick red and blue. Once its blinking red and blue, they are ready to connect with your device.'),
            SizedBox(height: 5.0),
            Text('3. if the Earbud is connected it blicks blue and your are ready to go!'),
            SizedBox(height: 20.0),
            Text(
              'RESET',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text('If the earbuds are still not connecting to your device, you can reset them by putting them in the their box. After waiting 5 seconds, try it again.'),
          ],
        ),
        actions: [
          ElevatedButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Esense Sport App',
          style: TextStyle(
            letterSpacing: 1,
          ),
          ),
        backgroundColor: Colors.blueGrey[700],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'WELCOME 👋🏼',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                '1. Make sure that your Earables are connected with your phone :',
                style: TextStyle(
                  fontSize: 16.0,
                  //backgroundColor: Colors.amber,
                ),
              ),
              SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        'Earbuds Status: ',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        '\t$_deviceStatus',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: _statusColor,
                        ),
                      ),
                    ],
                  ),
                  // Text('eSense Device Status: \t$_deviceStatus'),
                  //Text('eSense Device Name: \t$_deviceName'),
                  //Text('eSense Device Name: \t$eSenseName'),
                  //Text('eSense Battery Level: \t$_voltage'),
                  //Text('eSense Button Event: \t$_button'),
                  //Text('yo'),
                  Text('$_event'),
                ],
              ),
              SizedBox(
                height: 40.0,
                width: 170.0,
                child: ElevatedButton(
                  //padding: EdgeInsets.all(15.0),
                  onPressed: () {
                    createAlertDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[300],
                    side: BorderSide(width: 1.3, color: Colors.grey[400],),
                    elevation: 2,
                  ),
                  //color: Colors.greenAccent,
                  child: Text(
                    'Connection Help',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                '2. Setup the Workout that fits you !',
                style: TextStyle(
                  fontSize: 16.0,
                  //backgroundColor: Colors.amber,
                ),
              ),
              SizedBox(height: 30.0),
              SizedBox(
                height: 50.0,
                width: 230.0,
                child: ElevatedButton(
                  //padding: EdgeInsets.all(15.0),
                  onPressed: () {
                    Navigator.pushNamed(context, '/setup_workout_2');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal[700],
                    elevation: 5,
                  ),
                  //color: Colors.greenAccent,
                  child: Text(
                    'Setup your Workout!',
                    style: TextStyle(
                      fontSize: 17.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              FloatingActionButton(
                // a floating button that starts/stops listening to sensor events.
                // is disabled until we're connected to the device.
                onPressed:
                    (!ESenseManager.connected) ? null : (!sampling) ? _startListenToSensorEvents : _pauseListenToSensorEvents,
                tooltip: 'Listen to eSense sensors',
                child: (!sampling) ? Icon(Icons.play_arrow) : Icon(Icons.pause),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
