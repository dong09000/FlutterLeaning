import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo 003',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: SampleAppPage(),
      home: MyFadeTest(title: 'Fade Test Demo',),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  SampleAppPage({Key key}): super(key: key);

  @override
  _SampleAppPageState createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  // Default value for toggle
  bool toggle = true;
  void _toggle() {
    setState(() {
      toggle = !toggle;
    });
  }

  _getToggleChild() {
    if (toggle) {
      return Text('Toggle One');
    } else {
      return CupertinoButton(
        onPressed: (){},
        child: Text('Toggle Two'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Flutter 003'),
      ),
      body: Center(
        child: _getToggleChild(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggle,
        tooltip: 'Update subview',
        child: Icon(Icons.update),
      ),

    );
  }
}

class MyFadeTest extends StatefulWidget {
  MyFadeTest({Key key, this.title}): super(key: key);

  final String title;

  @override
  _MyFadeTest createState() => _MyFadeTest();
}

class _MyFadeTest extends State<MyFadeTest> with TickerProviderStateMixin {
  AnimationController controller;
  CurvedAnimation curve;

  @override
  void initState() {
    controller = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    curve = CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }

  bool shouldIn = false;
  void _animateState() {
    setState(() {
      shouldIn = !shouldIn;
    });
    controller.forward();

  }

  _fadeTransition() {
    if (shouldIn) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: controller, curve: Curves.easeIn),
        child: FlutterLogo(
          size: 100.0,
        ),
      );
    } else {
      return FadeTransition(
        opacity: CurvedAnimation(parent: controller, curve: Curves.bounceOut),
        child: FlutterLogo(size: 0,),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          child: _fadeTransition(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Fade',
        child: Icon(Icons.brush),
        onPressed: _animateState,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
}