import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modeltraining/page/classifier.dart';
import 'package:image/image.dart' as img;
import 'package:modeltraining/page/classifier_quant.dart';
import 'package:logger/logger.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

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
  var logger = Logger();
  File? _image;
  final picker = ImagePicker();
  Image? _imageWidget;
  img.Image? fox;
  Category? category;

  @override
  void initState() {
    super.initState();
    _clasifier=ClassifierQuant();
  }
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image= File(pickedFile!.path);
      _imageWidget=Image.file(_image!);
      _predict();
    });
  }

  void _predict() async {
    img.Image imageInput=img.decodeImage(_image!.readAsBytesSync())!;
    var pred=_clasifier.predict(imageInput);
    setState(() {
      this.category=pred;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TFlite Gatos y Perros iwi'),
      ),
      body: Column(
        children:<Widget>[
          Center(
            child: _image==null?Text('Ninguna imagen seleccionada :c')
                :Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height/2,
              ),
              decoration: BoxDecoration(
                  border: Border.all()
              ),
              child: _imageWidget,
            ),
          ),
          SizedBox(
            height: 36,
          ),
          Text(
            category!=null?category!.label:'',
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            category!=null
                ?'Nivel de confianza :${(category!.score).toStringAsFixed(3)}'
                :''
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Seleccionar Imagen',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}