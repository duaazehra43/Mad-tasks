import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: RandomUserList(),
      ),
    );
  }
}

class RandomUserList extends StatefulWidget {
  @override
  _RandomUserListState createState() => _RandomUserListState();
}

class _RandomUserListState extends State<RandomUserList> {
  List<Map<String, dynamic>> userList = [];

  @override
  void initState() {
    super.initState();
    fetchRandomUserList();
  }

  Future<void> fetchRandomUserList() async {
    try {
      final response =
          await http.get(Uri.parse('https://randomuser.me/api/?results=10'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          userList = List<Map<String, dynamic>>.from(data['results']);
        });
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return userList.isNotEmpty
        ? ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              final user = userList[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user['picture']['medium']),
                ),
                title: Text('${user['name']['first']} ${user['name']['last']}'),
                subtitle: Text('Email: ${user['email']}'),
              );
            },
          )
        : Center(child: CircularProgressIndicator());
  }
}
