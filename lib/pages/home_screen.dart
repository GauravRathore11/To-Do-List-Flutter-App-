import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> tasks = [
    {"title": "Task 1", "isCompleted": false},
    {"title": "Task 2", "isCompleted": false},
  ];

  var taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Tasks',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            flex: 9,
            child: ListView(
              children: tasks
                  .map((task) => Card(
                        shadowColor: Colors.white,
                        child: ListTile(
                          leading: Checkbox(
                              value: task["isCompleted"],
                              onChanged: (bool? value) {
                                task["isCompleted"] = !task["isCompleted"];
                                setState(() {
                                  value = task["isCompleted"];
                                });
                              }),
                          title: Text('${task["title"]}',
                            style: TextStyle(
                              decoration: task["isCompleted"]? TextDecoration.lineThrough:TextDecoration.none
                            ),
                          ),
                          trailing: InkWell(
                              onTap: () {
                                setState(() {
                                  tasks.remove(task);
                                });
                              },
                              child: Icon(Icons.delete)),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Card(
            shadowColor: Colors.black,
            child: Expanded(
              flex: 1,
              child: TextField(
                controller: taskController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('New Task'),
                    suffix: InkWell(
                        onTap: () {
                          if (taskController != null) {
                            var newTask = taskController.text.toString();
                            tasks.add({"title": newTask, "isCompleted": false});
                            setState(() {
                              taskController.clear();
                            });
                          }
                        },
                        child: Icon(
                          Icons.send,
                          size: 30,
                        ))),
              ),
            ),
          )
        ]),
      ),
    );
  }
}