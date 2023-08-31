import 'package:bloc/bloc.dart';
import 'package:learn_bloc/main.dart';
import 'package:learn_bloc/model/todo_model.dart';
import 'package:meta/meta.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial()); //[] => 0

  void fetchTodos() async {
    emit(HomeLoading(todos: state.todos)); // [] => 0
    try {
      final todos = await sql.todos();
      emit(HomeFetchSuccess(todos: todos)); // [] => 2
    } catch(e) {
      emit(HomeFailure(todos: state.todos, message: "HOME ERROR: $e"));
    }
  }
}
