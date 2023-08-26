part of 'detail_cubit.dart';

@immutable
abstract class DetailState {
  const DetailState();
}

class DetailInitial extends DetailState {}

class DetailFailure extends DetailState {
  final String message;
  const DetailFailure({required this.message});
}

class DetailLoading extends DetailState {}

class DetailCreateSuccess extends DetailState {}
class DetailReadSuccess extends DetailState {}
class DetailUpdateSuccess extends DetailState {}
class DetailDeleteSuccess extends DetailState {}
