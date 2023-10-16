import 'package:flutter/material.dart';
import 'package:lab_tasks_8/Students.dart';
import 'package:lab_tasks_8/dbHelper.dart';
import 'package:lab_tasks_8/student_Details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController rollno = TextEditingController();
  TextEditingController name = TextEditingController();
  int selectedId = -1;
  List<Students> notes = [];

  _loadnotes() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    final notelist = await databaseHelper.queryAll();
    setState(() {
      notes = notelist;
    });
  }

  Future<void> update(dynamic updatedData) async {
    if (updatedData != null && updatedData is Students) {
      final updatedStudentIndex =
          notes.indexWhere((student) => student.id == updatedData.id);
      if (updatedStudentIndex != -1) {
        setState(() {
          notes[updatedStudentIndex] = updatedData;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadnotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(
                  labelText: "Name",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: rollno,
                decoration: const InputDecoration(
                  labelText: "Rollno",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(children: [
                ElevatedButton(
                  onPressed: () async {
                    DatabaseHelper dbHelper = DatabaseHelper();
                    Students note = Students(
                      rollno: rollno.text,
                      name: name.text,
                    );
                    await dbHelper.insert(note);
                    _loadnotes();
                  },
                  child: const Text("Insert Task"),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    DatabaseHelper dbHelper = DatabaseHelper();
                    Students note = Students(
                      id: selectedId,
                      rollno: rollno.text,
                      name: name.text,
                    );
                    await dbHelper.update(note);
                    _loadnotes();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Student data updated.'),
                      duration: Duration(seconds: 2),
                    ));
                    rollno.text = '';
                    name.text = '';
                    setState(() {
                      selectedId = -1;
                    });
                  },
                  child: const Text("Update Task"),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final updatedData = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Detail(),
                      ),
                    );
                    update(updatedData);
                  },
                  child: const Text("List Of Students"),
                ),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
