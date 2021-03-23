import 'package:flutter/material.dart';

class Workout extends StatefulWidget {
  @override
  _WorkoutState createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  var exerciseIndex = 0;

  void _finishExercise() {
    if (exerciseIndex == 3) {
      print('finish page');
      Navigator.pushNamed(context, '/finish');
    } 
    else if (exerciseIndex == 2 && data["repetitions"][exerciseIndex + 1] == '0') {
      print('if 0 v1');
      Navigator.pushNamed(context, '/finish');
    } 
    else if (exerciseIndex == 1 && data["repetitions"][exerciseIndex + 1] == '0' && data["repetitions"][exerciseIndex + 2] == '0') {
      print('if 0 v2');
      Navigator.pushNamed(context, '/finish');
    } 
    else if (exerciseIndex == 0 && data["repetitions"][exerciseIndex + 1] == '0' && data["repetitions"][exerciseIndex + 2] == '0' && data["repetitions"][exerciseIndex + 3] == '0') {
      print('if 0 v3');
      Navigator.pushNamed(context, '/finish');
    }
    else if (data["repetitions"][exerciseIndex + 1] == '0') {
      print('if 0');
      setState(() {
        exerciseIndex += 2;
      });
      print(exerciseIndex);
      if (data["repetitions"][exerciseIndex] == '0') {
        print('if 0 et 0');
        setState(() {
          exerciseIndex += 1;
        });
      }
    } 
    else {
      print('normal');
      setState(() {
        exerciseIndex += 1;
      });
    }
  }

  createAlertDialog(BuildContext context) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Are you sure you want to quit?'),
        //content: Text('At least one exercise must contain repetitions! Please try it again.'),
        actions: [
          ElevatedButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.grey[500],
            ),
          ),
          SizedBox(width: 10.0),
          ElevatedButton(
            child: Text('Yes'),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/home'));
            },
          ),
          SizedBox(width: 10.0),
        ],
      );
    });
  }

  

  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    print(data);

    if (data["repetitions"][exerciseIndex] == '0') {
      exerciseIndex += 1;
      if (data["repetitions"][exerciseIndex] == '0') {
        exerciseIndex += 1;
        if (data["repetitions"][exerciseIndex] == '0') {
          exerciseIndex += 1;
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[400],
        automaticallyImplyLeading: false,
        title: Text('Workout Session'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 20.0),
                Text(
                  //'EXERCISE :',
                  'EXERCISE :',
                  style: TextStyle(
                    color: Colors.grey[600],
                    letterSpacing: 1.4,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  data["exercises"][exerciseIndex],
                  style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            //SizedBox(height: 30.0),
            Container(
              width: 270.0,
              height: 270.0,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      '2',
                      style: TextStyle(
                        fontSize: 170.0,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: 220.0,
                    child: Text(
                      '/ ${data["repetitions"][exerciseIndex]}',
                      style: TextStyle(
                        fontSize: 50.0,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0)),
                color: Colors.green.shade600,
                border: Border.all(color: Colors.grey[300]),
                boxShadow: [
                  //background color of box
                  BoxShadow(
                    color: Colors.grey[300],
                    blurRadius: 25.0, // soften the shadow
                    spreadRadius: 5.0, //extend the shadow
                    offset: Offset(
                      10.0, // Move to right 10  horizontally
                      10.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        createAlertDialog(context);

                        // Navigator.popUntil(context, ModalRoute.withName('/home'));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[400],
                        onPrimary: Colors.white,
                        elevation: 5,
                      ),
                      child: Text(
                        'Quit Workout',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _finishExercise,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrange,  //change background color
                        onPrimary: Colors.white, // text color
                        elevation: 5,
                        // shadowColor: to change the shadow color
                      ),
                      child: Text(
                        'Next Exercise',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
