part of 'home_cubit.dart';

@immutable
abstract class HomeState {
  final List<Todo> todos;
  const HomeState({required this.todos});
}

class HomeInitial extends HomeState {
  const HomeInitial() : super(todos: const []);
}

class HomeLoading extends HomeState {
  const HomeLoading({required super.todos});
}

class HomeFailure extends HomeState {
  final String message;
  const HomeFailure({required super.todos, required this.message});
}

class HomeFetchSuccess extends HomeState {
  const HomeFetchSuccess({required super.todos});
}

