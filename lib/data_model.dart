import 'dart:convert';

class Todomodelapi {
    List<Todo> todos;

    Todomodelapi({
        required this.todos,
    });

    factory Todomodelapi.fromRawJson(String str) => Todomodelapi.fromJson(json.decode(str));

    factory Todomodelapi.fromJson(Map<String, dynamic> json) => Todomodelapi(
        todos: List<Todo>.from(json["todos"].map((x) => Todo.fromJson(x))),
    );

}

class Todo {
    int id;
    String todo;
    bool completed;
    int userId;

    Todo({
        required this.id,
        required this.todo,
        required this.completed,
        required this.userId,
    });

    factory Todo.fromRawJson(String str) => Todo.fromJson(json.decode(str));


    factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["id"],
        todo: json["todo"],
        completed: json["completed"],
        userId: json["userId"],
    );
}
