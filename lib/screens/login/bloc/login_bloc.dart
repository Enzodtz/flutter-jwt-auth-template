import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_jwt_auth_example/exceptions/form_exceptions.dart';
import 'package:flutter_jwt_auth_example/model/user_model.dart';
import 'package:flutter_jwt_auth_example/services/auth_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginFormState()) {
    on<LoginRequestEvent>((event, emit) async {
      emit(LoginLoadingState());
      try {
        final user = await AuthService.login(
          email: event.email,
          password: event.password,
        );
        emit(LoginSuccessState(
          user,
        ));
      } on FormGeneralException catch (e) {
        emit(LoginErrorState(e));
      } on FormFieldsException catch (e) {
        emit(LoginErrorState(e));
      } catch (e) {
        emit(LoginErrorState(
          FormGeneralException(message: 'Unidentified error'),
        ));
      }
    });
  }
}
