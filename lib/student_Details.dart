import 'package:flutter/material.dart';
import 'package:lab_tasks_8/Students.dart';
import 'package:lab_tasks_8/dbHelper.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => DetailState();
}

class DetailState extends State<Detail> {
  TextEditingController rollno = TextEditingController();
  TextEditingController name = TextEditingController();
  int selectedId = -1;
  List<Students> students = [];

  _loadnotes() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    final notelist = await databaseHelper.queryAll();
    setState(() {
      students = notelist;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadnotes();
  }

  void update2() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    Students stud =
        Students(id: selectedId, rollno: rollno.text, name: name.text);

    if (selectedId == -1) {
      await dbHelper.insert(stud);
    } else {
      await dbHelper.update(stud);
    }
    Navigator.of(context).pop(stud);
  }

  void search(String query) async {
    if (query.isEmpty) {
      _loadnotes();
    } else {
      DatabaseHelper dbHelper = DatabaseHelper();
      final searchResults = await dbHelper.searchStudents(query);
      setState(() {
        students = searchResults;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) {
                  search(value);
                },
                decoration: const InputDecoration(
                  hintText: "Search Students Here!...",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 400,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                child: Expanded(
                  child: ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final note = students[index];
                      return ListTile(
                        title: Text(note.rollno),
                        subtitle: Text(note.name),
                        trailing:
                            Row(mainAxisSize: MainAxisSize.min, children: [
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              DatabaseHelper dbHelper = DatabaseHelper();
                              await dbHelper.delete(note.id!);
                              _loadnotes();
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              update2();
                            },
                          ),
                        ]),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
