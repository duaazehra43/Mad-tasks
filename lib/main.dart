import 'package:flutter/material.dart';

void main() {
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Chat App'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Chats'),
                Tab(text: 'Status'),
                Tab(text: 'Calls'),
                Tab(text: 'Settings'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              Center(child: Text('Chats')),
              Center(child: Text('Status')),
              Center(child: Text('Calls')),
              Center(child: Text('Settings')),
            ],
          ),
        ),
      ),
    );
  }
}
