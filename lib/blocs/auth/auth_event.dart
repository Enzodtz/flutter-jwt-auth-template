part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthLoadUserEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class AuthAuthenticateEvent extends AuthEvent {
  final User user;

  const AuthAuthenticateEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthLogoutEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}
