class Todo {
  int id;
  String title;
  String description;
  bool isCompleted;

  Todo(
      {required this.id,
      required this.title,
      required this.description,
      required this.isCompleted});

  factory Todo.fromJson(Map<String, Object?> json) {
    return Todo(
      id: json["id"] as int,
      title: json["title"] as String,
      description: json["description"] as String,
      isCompleted: json["isCompleted"] == 1 ? true : false,
    );
  }

  Map<String, Object> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "isCompleted": isCompleted ? 1: 0,
      };

  @override
  int get hashCode => Object.hash(id, title, isCompleted);

  @override
  bool operator ==(Object other) {
    return other is Todo &&
        other.title == title &&
        other.id == id &&
        other.isCompleted == isCompleted;
  }

  @override
  String toString() {
    return "$id. title: $title, desc: $description. ";
  }
}
