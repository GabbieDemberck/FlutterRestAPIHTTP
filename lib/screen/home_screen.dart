import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rest_api/controller/todo_controller.dart';
import 'package:flutter_rest_api/repository/todo_repository.dart';

class HomeScreen extends StatelessWidget {
  var todoController = TodoController(TodoRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('APP REST API'),
      ),
      body: FutureBuilder(
        future: todoController.fetchTodoList(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('error'),
            );
          }
          return ListView.separated(
              itemBuilder: (context, index) {
                var todo = snapshot.data[index];
                return Container(
                  height: 100.0,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(flex: 1, child: Text('${todo?.id}')),
                      Expanded(flex: 3, child: Text('${todo?.title}')),
                      Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                  onTap: () {
                                    todoController
                                        .updatePatchCompleted(todo!)
                                        .then((value) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              content: Text('{$value}')));
                                    });
                                  },
                                  child: buildCallContainer(
                                      'Patch', Color(0xFFFFE0B2))),
                              InkWell(
                                  child: buildCallContainer(
                                      'Put', Color(0xFFB39DDB))),
                              InkWell(
                                  child: buildCallContainer(
                                'Del',
                                Color(0xFFE57373),
                              ))
                            ],
                          )),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  thickness: 0.5,
                  height: 0.5,
                );
              },
              itemCount: snapshot.data?.length ?? 0);
        },
      ),
    );
  }

  Container buildCallContainer(String title, Color color) {
    return Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text('$title'),
        ));
  }
}
