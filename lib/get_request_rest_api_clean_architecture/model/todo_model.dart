class ToDoModel {
  ToDoModel({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  int userId;
  int id;
  String title;
  bool completed;

  factory ToDoModel.fromJson(Map<String, dynamic> json) => ToDoModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
      );
}
