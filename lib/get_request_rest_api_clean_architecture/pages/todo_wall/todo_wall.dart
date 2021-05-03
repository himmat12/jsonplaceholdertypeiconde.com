import 'package:flutter/material.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/controller/todo_controller.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/model/todo_model.dart';
import 'package:get_request_rest_api/get_request_rest_api_clean_architecture/utils/auth.dart';
import 'package:get/get.dart';

import '../../../enum.dart';

class ToDOWall extends StatelessWidget {
  final toDoController = Get.put(ToDoController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: 'todo',
      init: toDoController,
      initState: (_) {
        toDoController.getToDos(userId: Auth.userId);
      },
      builder: (_) {
        return Obx(
          () => toDoController.toDoState.value != ViewState.RETRIVED
              ? Center(
                  child: Text('initializing ...'),
                )
              : ListView(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Text(
                      'ToDos & Tasks',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      color: Colors.blueGrey,
                      child: Text(
                        "NOTE* [ (pending => completed) data is persistence only on this page's lifetime (being GET request it's not possible to update data in api but it has been updated locally on local object) ]",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: 16,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: toDoController.toDos.length,
                      itemBuilder: (context, index) {
                        ToDoModel todo = toDoController.toDos[index];
                        return Container(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                          ),
                          child: Row(
                            children: [
                              Text(
                                '#${todo.id}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 8),
                              Expanded(child: Text(todo.title)),
                              SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  print('check todo');
                                  toDoController.completeToDo(todo);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 60,
                                  width: 80,
                                  color: todo.completed == true
                                      ? Colors.green
                                      : Colors.red,
                                  child: Text(
                                    todo.completed == true
                                        ? 'completed'
                                        : 'pending',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                ),
        );
      },
    );
  }
}
