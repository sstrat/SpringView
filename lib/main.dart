import 'package:flutter/material.dart';
import 'package:social_app/Mapping.dart';
import 'Authentification.dart';
void main(){
  runApp(new BlogApp());
}

class BlogApp extends StatelessWidget {
  @override
    Widget build(BuildContext context){
      return new MaterialApp(
        title: "Social App",
        theme: new ThemeData(
          primarySwatch: Colors.green,
        ),
        home: MappingPage(auth: Auth(),),
      );
    }
}