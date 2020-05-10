import 'package:flutter/material.dart';
import 'package:pauzr/timer.dart';
//import 'package:pauzr/timer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

@override
Widget build(BuildContext context){
  return MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.teal,
     
      body: SafeArea(
        child: PauzrStful(),
      ),
      
    ),
     theme: ThemeData(
        canvasColor: Colors.blueGrey,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        accentColor: Colors.pinkAccent,
        brightness: Brightness.dark,
      ),

    
    /*routes: {
      PauzrTimerStless.routeName : (context) => PauzrTimerStless(),
    },*/

  );
}

}

class PauzrStful extends StatefulWidget {
  @override
  _PauzrStfulState createState() => _PauzrStfulState();
}



class _PauzrStfulState extends State<PauzrStful> {

  
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          RaisedButton(
            child: Text(' 10 min.\n5 points',
            style: TextStyle(fontSize: 20.0),),
            textColor: Colors.blue,
            color: Colors.black, 
            
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => PauzrTimer(time_set: 10,points_over: 5,)));
            },

            ),
          RaisedButton(
            color: Colors.black,
            
            child: Text('  20 min.\n10 points',
            style: TextStyle(color: Colors.pinkAccent,
            fontSize: 20.0,),),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => PauzrTimer(time_set: 20,points_over: 10,)));
            },
            ),
          RaisedButton(
              child: Text(' 30 min.\n20 points',
              style: TextStyle(fontSize: 20.0),),
              textColor: Colors.blue,
              color: Colors.black,
              onPressed: (){ 
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => PauzrTimer(time_set: 30,points_over: 20,)));
              },
              ),
        ],
      ),
    );
  }
}