import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nxgenpro_retrofit_task/Screens/CommentScreen.dart';
import 'package:nxgenpro_retrofit_task/Screens/PostScreen.dart';
import 'package:nxgenpro_retrofit_task/Screens/UserScreen.dart';
import 'package:nxgenpro_retrofit_task/repository/model/Comments.dart';
import 'package:nxgenpro_retrofit_task/repository/model/Posts.dart';
import 'package:nxgenpro_retrofit_task/repository/model/data.dart';
import 'package:nxgenpro_retrofit_task/repository/retrofit/api_client.dart';
import 'package:retrofit/http.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: CommentScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/commentscreen': (context) => CommentScreen(),
        '/userscreen': (context) => UserScreen(),
        '/postscreen': (context) => PostScreen(),
      },
    );
  }
}
