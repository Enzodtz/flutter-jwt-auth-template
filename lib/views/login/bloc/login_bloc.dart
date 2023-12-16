import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:axalta/exceptions/form_exceptions.dart';
import 'package:axalta/model/user_model.dart';
import 'package:axalta/services/auth_service.dart';
import 'dart:developer' as devtools show log;

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
        devtools.log(e.toString());
        emit(LoginErrorState(
          FormGeneralException(message: 'Unidentified error'),
        ));
      }
    });
  }
}
