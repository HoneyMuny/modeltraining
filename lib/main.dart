import 'package:flutter/material.dart';
import 'package:modeltraining/page/classifier.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Classificator',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(
        title: 'flutter Demo Home Page'
      ),
    );
  }
}

class MyHomePage extends StatefulWidget{
  MyHomePage({Key? key, this.title}): super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage>{
  late Classifier _clasifier;

  @override
  Widget build(BuildContext context) {

  }

}

