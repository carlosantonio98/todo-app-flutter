
class Task {
  String id;
  final String todo;
  final bool done;

  Task({
    this.id = '',
    required this.todo,
    required this.done
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'todo': todo,
    'done': done
  };

  static Task fromJson(Map<String, dynamic> json) => Task(
    id: json['id'], 
    todo: json['todo'], 
    done: json['done']
  );
}