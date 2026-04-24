import 'package:meet8/domain/entities/user_entity.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<UserEntity> Users;
  UserLoaded(this.Users);
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}
