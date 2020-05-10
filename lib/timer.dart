import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'main.dart';



class PauzrTimer extends StatefulWidget {
  
    int time_set;
    int points_over;

    PauzrTimer({this.time_set,this.points_over});

    @override
  _PauzrTimerState createState() => _PauzrTimerState();
}

class _PauzrTimerState extends State<PauzrTimer> with TickerProviderStateMixin{

get isPlaying => null;

  showCompleted(BuildContext context)
  {
      return showDialog(context: context,builder: (context){
       return AlertDialog(
        title: Text("You have Earned $widget.points_over points."),
        //content: Text("Are you sure you want to pause?"),
        actions: <Widget>[
          FlatButton(child: Text("Confirm"),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyApp()));
          },
          ),
          /*FlatButton(child: Text("No"),
          onPressed: () {
            return ;
          },)*/
        ],
      );
      });
  }
  
  Future<String> createAlertDialog(BuildContext context){
    TextEditingController customController = TextEditingController();
    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("Are you sure you want to pause?"),
        //content: Text("Are you sure you want to pause?"),
        actions: <Widget>[
          FlatButton(child: Text("Yes"),
          onPressed: () {
            Navigator.pushNamed(context,"/");
          },
          ),
          FlatButton(child: Text("No"),
          onPressed: () {
            Navigator.pop(context);
          },)
        ],
      );
    });
  }



  AnimationController controller;

   //bool isPlaying = false;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    //
    
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    print(widget.time_set);
    controller = AnimationController(
      
      vsync: this,
      duration: Duration(minutes:widget.time_set,seconds: 00),
    );

    // ..addStatusListener((status) {
    //     if (controller.status == AnimationStatus.dismissed) {
    //       setState(() => isPlaying = false);
    //     }

    //     print(status);
    //   })
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: FractionalOffset.center,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: AnimatedBuilder(
                          animation: controller,
                          builder: (BuildContext context, Widget child) {
                            return CustomPaint(
                                painter: TimerPainter(
                              animation: controller,
                              backgroundColor: Colors.white,
                              color: themeData.indicatorColor,
                            ));
                          },
                        ),
                      ),
                      Align(
                        alignment: FractionalOffset.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Ends In",
                              style: TextStyle(
                                fontSize: 20.0,
                                ),

                            ),
                            AnimatedBuilder(
                                animation: controller,
                                builder: (BuildContext context, Widget child) {
                                  
                                  return Text(
                                    timerString,
                                    style: themeData.textTheme.display4,
                                  );
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    child: AnimatedBuilder(
                      animation: controller,
                      builder: (BuildContext context, Widget child) {
                        
                      return Icon(controller.isAnimating
                            ? Icons.timer
                            : Icons.play_arrow);
                      
                        
                      },
                    ),
                    onPressed: () {
                       //setState(() => isPlaying = !isPlaying);

                      if (controller.isAnimating) {
                        createAlertDialog(context);
                        
                      } else {
                        if(controller.isCompleted==true) 
                          showCompleted(context);
                        controller.reverse(
                            from: controller.value == 0.0
                                ? 1.0
                                : controller.value);

                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
  
      
    );
  }
}

class TimerPainter extends CustomPainter {
  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);



  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    //double distance=size.width / 2.0;
    //Offset p1=Offset(distance,distance);
    //Offset p2=Offset(distance+10.0,distance+10.0);
    //canvas.drawLine(p1,p2, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    //if(animation.value==old.animation.value)
      //showCompleted(context);
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}


