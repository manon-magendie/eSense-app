import 'package:flutter/material.dart';

class SetupWorkout extends StatefulWidget {
  @override
  _SetupWorkoutState createState() => _SetupWorkoutState();
}

class _SetupWorkoutState extends State<SetupWorkout> {

  String squats;
  String pushUps;
  String crunches;
  String jumpingJacks;

  final GlobalKey<FormState> _formKeyValue = GlobalKey<FormState>();

  String _validateRepetitions(String reps) {
  RegExp regex = RegExp(r'^[0-9]+$'); 
  if (reps.isEmpty)
    return 'Please enter the repetitions';
  else if (!regex.hasMatch(reps))
    return "Please enter an integer";
  else
    return null;
}

  Widget _squats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Squats',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(width: 20.0),
            Container(
              width: 150.0,
              child: TextFormField(
                maxLength: 3,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Repetitions',
                  labelStyle: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                validator: _validateRepetitions,
                onSaved: (String value) {
                  squats = value;
                },
              ),
            ),
          ],
    );
  }

  Widget _pushUps() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Push-Ups',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(width: 20.0),
            Container(
              width: 150.0,
              child: TextFormField(
                maxLength: 3,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Repetitions',
                  labelStyle: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                validator: _validateRepetitions,
                onSaved: (String value) {
                  pushUps = value;
                },
              ),
            ),
          ],
    );
  }

  Widget _crunches() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Crunches',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(width: 20.0),
            Container(
              width: 150.0,
              child: TextFormField(
                maxLength: 3,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Repetitions',
                  labelStyle: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                validator: _validateRepetitions,
                onSaved: (String value) {
                  crunches = value;
                },
              ),
            ),
          ],
    );
  }

  Widget _jumpingJacks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Jumping-Jacks',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(width: 20.0),
            Container(
              width: 150.0,
              child: TextFormField(
                maxLength: 3,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Repetitions',
                  labelStyle: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                validator: _validateRepetitions,
                onSaved: (String value) {
                  jumpingJacks = value;
                },
              ),
            ),
          ],
    );
  }

  List exercises = ['Squats', 'Push-ups', 'Crunches', 'Jumping-jacks'];
  List repetitions = [0, 0, 0, 0];

  createAlertDialog(BuildContext context) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Empty Workout'),
        content: Text('At least one exercise must contain repetitions! Please try it again.'),
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
      appBar: AppBar(
        backgroundColor: Colors.grey[500],
        title: Text('Setup your Workout!'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  SizedBox(height: 20.0),
                  Text(
                    'Create the Workout that fits you!',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent[700],
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    'Enter the number of repetitions you want to do for each workout exercise :',
                    style: TextStyle(
                      fontSize: 14.0,
                      letterSpacing: 1.2,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              Form(
                key: _formKeyValue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _squats(),
                    _pushUps(),
                    _crunches(),
                    _jumpingJacks(),
                  ],
                ),
              ),
              SizedBox(height: 40.0),
              ElevatedButton(
                //padding: EdgeInsets.all(15.0),
                onPressed: () {
                  if(!_formKeyValue.currentState.validate()){
                    // if the validation is not right
                    print('problem');
                    return;
                  }

                  // if the validation is correct
                  //calls the onSave Method
                  else { 
                    print('all good');
                    _formKeyValue.currentState.save();
                  
                    repetitions[0] = squats;
                    repetitions[1] = pushUps;
                    repetitions[2] = crunches;
                    repetitions[3] = jumpingJacks;

                    if(squats == '0' && pushUps == '0' && crunches == '0' && jumpingJacks == '0'){
                    print('all 0');
                    createAlertDialog(context);
                    //   AlertDialog(title: Text("At least one exercise must have some repetitions!"));
                    }

                    else {
                    Navigator.pushNamed(context, '/workout', arguments: {
                      // a set of key value pairs that we can pass through
                      'exercises': exercises,
                      'repetitions': repetitions,
                    });
                    }
                  }
                  
                },
                //color: Colors.greenAccent,
                child: Text(
                  'Start Workout',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
            ]
          ),
        ),
      ),
    );
  }
}

/* DELETE FUNCTION :

 exercises.map((ex) => ExerciseCard(
                  ex: ex,
                  delete: () {
                    setState(() {
                      exercises.remove(ex);
                    });
                  }
                )).toList(),

*/

