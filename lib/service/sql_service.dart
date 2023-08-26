import 'package:learn_bloc/model/todo_model.dart';
import 'package:sqflite/sqflite.dart';

const String tableTodo = 'TODO';

class SQLService {
  late Database db;

  Future<void> open(String path) async {
    db = await openDatabase(path, version: 1);
    if(!db.isOpen) {
      await db.execute('''
create table TODO ( 
  id integer primary key autoincrement, 
  title text not null,
  description text not null,
  isCompleted integer not null)
''');
    }
  }

  Future<Todo> insert(Todo todo) async {
    todo.id = await db.insert(tableTodo, todo.toJson()..remove("id"));
    return todo;
  }

  Future<int> delete(int id) async {
    return await db.delete(tableTodo, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Todo todo) async {
    return await db.update(tableTodo, todo.toJson(), where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<Todo?> getTodo(int id) async {
    List<Map> maps = await db.query(tableTodo,
        where: 'id = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Todo.fromJson(Map<String, Object>.from(maps.first));
    }
    return null;
  }

  Future<List<Todo>> todos() async {
    List<Map> maps = await db.query(tableTodo);
    return maps.map((json) => Todo.fromJson(Map<String, Object>.from(json))).toList();
  }
}
