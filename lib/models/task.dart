
class Task {
  String id;
  final String todo;
  final bool done;
  final String userId;

  Task({
    this.id = '',
    required this.todo,
    required this.done,
    required this.userId
  });

  Map<String, dynamic> toJson() => {
    'id':     id,
    'todo':   todo,
    'done':   done,
    'userId': userId
  };

  static Task fromJson(Map<String, dynamic> json) => Task(
    id:     json['id'], 
    todo:   json['todo'], 
    done:   json['done'],
    userId: json['userId']
  );
}