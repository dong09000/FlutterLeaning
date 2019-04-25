import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      //home: Signature(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color lineColor = Colors.red;

  void _incrementCounter() {
    setState(() {
      lineColor = Colors.blue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
      child: Signature(lineColor: lineColor),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: Icon(Icons.track_changes),
        tooltip: 'hahaha',
      ),
    );
  }
}


class SignaturePainter extends CustomPainter {
  SignaturePainter(this.points, this.lineColor);

  final List<Offset> points;
  final Color lineColor;

  void paint(Canvas canvas, Size size) {
    var paint = Paint()
    ..color = lineColor
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i+1], paint);
      }
    }
  }

  bool shouldRepaint(SignaturePainter other) => other.points != points;
}

class Signature extends StatefulWidget {
  Signature({Key key, this.lineColor}) : super(key: key);

  final Color lineColor;

  SignatureState createState() => SignatureState(lineColor);
}

class SignatureState extends State<Signature> {
  SignatureState(this.lineColor);
  final Color lineColor;
  List<Offset> _points = <Offset>[];

  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        setState(() {
          RenderBox referenceBox = context.findRenderObject();
          Offset localPosition = referenceBox.globalToLocal(details.globalPosition);
          _points = List.from(_points)..add(localPosition);
        });
      },
      onPanEnd: (DragEndDetails details) => _points.add(null),
      child: CustomPaint(painter: SignaturePainter(_points, lineColor), size: Size.infinite,),
    );
  }
}