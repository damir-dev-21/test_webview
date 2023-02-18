import 'package:flutter/material.dart';
import 'package:webview_test/models/Task/Task.dart';

class TasksList extends StatelessWidget {
  const TasksList({Key? key, required this.tasks}) : super(key: key);

  static const String routeName = '/tasks';

  static Route route({required List<Task> tasks}) {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => TasksList(
              tasks: tasks,
            ));
  }

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/home', arguments: 2);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff1b2c57),
        shadowColor: Colors.white,
        elevation: 1,
      ),
      backgroundColor: const Color(0xff1b2c57),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        onPressed: () {
          Navigator.pushNamed(context, '/task',
              arguments: Task(0, '', '', '', 0));
        },
        child: Text('+'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (ctx, index) {
                final Task task = tasks[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/task', arguments: task);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 14, 27, 58),
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      iconColor: Colors.white,
                      textColor: Colors.white,
                      title: Text(task.title),
                      trailing: IconButton(
                          onPressed: () {}, icon: Icon(Icons.arrow_right)),
                    ),
                  ),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
