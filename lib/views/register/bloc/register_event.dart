part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterRequestEvent extends RegisterEvent {
  final String email;
  final String password;
  final String cellphone;
  final String firstName;
  final String lastName;

  const RegisterRequestEvent({
    required this.email,
    required this.password,
    required this.cellphone,
    required this.firstName,
    required this.lastName,
  });

  @override
  List<Object?> get props => [email, password];
}
