part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthLoadingState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthUnauthenticatedState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthAuthenticatedState extends AuthState {
  final User user;

  const AuthAuthenticatedState({required this.user});

  @override
  List<Object> get props => [user];
}
