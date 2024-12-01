import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var tasks = [];
  var taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  void saveData() async {
    var pref = await SharedPreferences.getInstance();

    String savedData = json.encode(tasks);
    pref.setString("tasks", savedData);
  }

  void loadTasks() async {
    var pref = await SharedPreferences.getInstance();
    String? tasksJson = pref.getString("tasks");

    if (tasksJson != null) {
      var decodedTasks = json.decode(tasksJson);
      tasks =
          decodedTasks.map((task) => Map<String, dynamic>.from(task)).toList();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Tasks',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
              flex: 9,
              child: tasks.isEmpty? 
                const Center(
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(text: 'Your\'re all caught up,\n',style: TextStyle(fontSize: 25,color: Colors.blueGrey)),
                      TextSpan(text: 'Time to take a BREAK!',style: TextStyle(fontSize: 30,color: Colors.lightBlueAccent))
                    ])
                  ),
                ) 
              : ListView(
                padding: EdgeInsets.symmetric(horizontal: 11),
                children: tasks
                    .map((task) => Container(
                          margin: EdgeInsets.only(bottom: 11),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? const [
                                        Color.fromARGB(255, 149, 74, 49),
                                        Color.fromARGB(255, 16, 90, 174),
                                        Color.fromARGB(210, 83, 97, 178)
                                      ]
                                    : const [
                                        Color.fromARGB(255, 202, 194, 192),
                                        Color.fromARGB(255, 141, 174, 211),
                                        Color.fromARGB(210, 169, 172, 195)
                                      ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ListTile(
                            leading: Checkbox(
                                value: task["isCompleted"],
                                onChanged: (bool? value) {
                                  task["isCompleted"] = !task["isCompleted"];
                                  setState(() {
                                    value = task["isCompleted"];
                                    saveData();
                                  });
                                }),
                            title: Text(
                              '${task["title"]}',
                              style: TextStyle(
                                  decoration: task["isCompleted"]
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                            ),
                            trailing: InkWell(
                                onTap: () {
                                  setState(() {
                                    tasks.remove(task);
                                    saveData();
                                  });
                                },
                                child: Icon(Icons.delete)),
                          ),
                        ))
                    .toList(),
              ),
            ),
            Container(
              margin: EdgeInsets.all(11),
              height: 60,
              child: TextField(
                controller: taskController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    label: Text('New Task'),
                    suffix: InkWell(
                        onTap: () {
                          if (taskController.text.isNotEmpty) {
                            var newTask = taskController.text.toString();
                            tasks.insert(
                                0, {"title": newTask, "isCompleted": false});
                            setState(() {
                              saveData();
                              taskController.clear();
                            });
                          }
                        },
                        child: const Icon(
                          Icons.send,
                          size: 30,
                        ))),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
