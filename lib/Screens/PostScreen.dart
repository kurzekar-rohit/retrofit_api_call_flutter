import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nxgenpro_retrofit_task/repository/model/Posts.dart';
import 'package:nxgenpro_retrofit_task/repository/retrofit/api_client.dart';
import 'package:google_fonts/google_fonts.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme)),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Posts',
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

  FutureBuilder<List<Posts>> _buildBody(BuildContext context) {
    final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder<List<Posts>>(
      future: client.getPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<Posts> posts = snapshot.data;
          return _buildListView(context, posts);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildListView(BuildContext context, List<Posts> posts) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(15.0),

          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${posts[index].title}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "${posts[index].body}",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.comment,
                        color: Colors.grey,
                      )
                    ],
                  ),
                  Divider(),
                ],
              ),
            ),
          ),
          // ),
        );
      },
      itemCount: posts.length,
    );
  }
}
