import 'package:flutter/material.dart';

class WorkoutDone extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: EdgeInsets.all(35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Text(
                  '🔥 🤗 🎉 🤩',
                  style: TextStyle(
                    fontSize: 40.0,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Well done!',
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.3,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'You finished the Workout!',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.grey[900],
                  ),
                ),
              ],
            ),
            SizedBox(height: 100.0),
            ElevatedButton(
              //padding: EdgeInsets.all(15.0),
              onPressed: () {
                //print(exerciseIndex);
                Navigator.popUntil(context, ModalRoute.withName('/setup_workout_2'));
              },
              //  arguments: {
              //     'exerciseIndex': exerciseIndex,
              //   }
              //color: Colors.greenAccent[700],
              child: Text(
                'Repeat the Workout',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              //padding: EdgeInsets.all(15.0),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/home'));
              },
              //color: Colors.green[800],
              child: Text(
                'Return to the home page',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
