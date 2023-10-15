import 'package:flutter/material.dart';

void main() {
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4, // You can customize the number of tabs.
        child: Scaffold(
          appBar: AppBar(
            title: Text('WhatsApp Clone'),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // Implement search functionality.
                },
              ),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  // Implement more options menu.
                },
              ),
            ],
            bottom: TabBar(
              tabs: [
                Tab(text: 'Chats'),
                Tab(text: 'Status'),
                Tab(text: 'Calls'),
                Tab(text: 'Settings'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // Chat tab content
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Contact $index'),
                  );
                },
              ),

              // Status tab content
              ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Status $index'),
                  );
                },
              ),

              // Calls tab content
              ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Call $index'),
                  );
                },
              ),

              // Settings tab content
              Center(child: Text('Settings')),
            ],
          ),
        ),
      ),
    );
  }
}
