import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:esense_flutter/esense.dart';
import 'package:flutter/services.dart';

import 'package:esense/pages/home.dart';
import 'package:esense/pages/connect_earables.dart';
import 'package:esense/pages/setup_workout.dart';
import 'package:esense/pages/workout.dart';
import 'package:esense/pages/workout_done.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/home',
  routes: {
    '/home': (context) => Home(),
    '/connect_earables': (context) => ConnectEarables(),
    '/setup_workout_2': (context) => SetupWorkout(),
    '/workout': (context) => Workout(),
    '/finish': (context) => WorkoutDone(),
  },
));

