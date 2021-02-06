import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nxgenpro_retrofit_task/repository/model/Comments.dart';
import 'package:nxgenpro_retrofit_task/repository/retrofit/api_client.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentScreen extends StatefulWidget {
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme)),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Comments',
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

  FutureBuilder<List<Comments>> _buildBody(BuildContext context) {
    final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder<List<Comments>>(
      future: client.getComments(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<Comments> comments = snapshot.data;
          return _buildListView(context, comments);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildListView(BuildContext context, List<Comments> comments) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]),
                  borderRadius: BorderRadius.circular(5.0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${comments[index].name}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "${comments[index].body}",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 12,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("- ${comments[index].email}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.grey))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      itemCount: comments.length,
    );
  }
}
