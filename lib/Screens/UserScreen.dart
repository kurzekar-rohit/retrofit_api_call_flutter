import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:nxgenpro_retrofit_task/repository/model/data.dart';
import 'package:nxgenpro_retrofit_task/repository/retrofit/api_client.dart';
import 'package:google_fonts/google_fonts.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  int _selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme)),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Users',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: _buildBody(context),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.comment),
              label: 'Comments',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.post_add),
              label: 'Posts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Users',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.purple,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0) {
      Navigator.pushNamed(context, '/commentscreen');
    }
    if (_selectedIndex == 1) {
      Navigator.pushNamed(context, '/postscreen');
    }
    if (_selectedIndex == 2) {
      Navigator.pushNamed(context, '/userscreen');
    }
  }

  FutureBuilder<List<User>> _buildBody(BuildContext context) {
    final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder<List<User>>(
      future: client.getUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<User> users = snapshot.data;
          return _buildListView(context, users);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildListView(BuildContext context, List<User> users) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(15.0),

          child: Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${users[index].name}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "User Name: ${users[index].username}",
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Email: ${users[index].email}",
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Website: ${users[index].website}",
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(),
                ],
              ),
            ),
          ),
          // ),
        );
      },
      itemCount: users.length,
    );
  }
}
