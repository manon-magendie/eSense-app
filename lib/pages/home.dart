import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        padding: const EdgeInsets.fromLTRB(50.0, 150.0, 50.0, 20.0),
        child: Center(
          child: Column(
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
              SizedBox(height: 40.0),
              Text(
                '1. Connect your Earables with your phone',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 30.0),
              SizedBox(
                height: 50.0,
                width: 230.0,
                child: ElevatedButton(
                  //padding: EdgeInsets.all(15.0),
                  onPressed: () {
                    Navigator.pushNamed(context, '/connect_earables');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal[300],
                    elevation: 5,
                  ),
                  //color: Colors.amber,
                  child: Text(
                    'Connect your earables',
                    style: TextStyle(
                      fontSize: 17.0,
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
            ],
          ),
        ),
      ),
    );
  }
}
