import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_jwt_auth_example/blocs/auth/auth_bloc.dart';
import 'package:flutter_jwt_auth_example/exceptions/form_exceptions.dart';
import 'package:flutter_jwt_auth_example/screens/register/register_screen.dart';
import 'package:flutter_jwt_auth_example/widgets/form_error_widget.dart';
import 'package:flutter_jwt_auth_example/widgets/success_dialog.dart';

import 'bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

  void submitForm(BuildContext context) {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final data = _formKey.currentState?.value;
      context.read<LoginBloc>().add(
            LoginRequestEvent(
              email: data!['email'],
              password: data['password'],
            ),
          );
    }
  }

  Future<bool> popScreen(state) async {
    return state is! LoginLoadingState;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return BlocProvider(
          create: (context) => LoginBloc(),
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccessState) {
                context.read<AuthBloc>().add(
                      AuthAuthenticateEvent(state.user),
                    );
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const SuccessDialog(
                      title: 'Success',
                      text: 'Your login was successful!',
                      buttonText: 'Continue',
                    );
                  },
                );
              }
            },
            builder: (context, state) {
              return WillPopScope(
                onWillPop: () => popScreen(state),
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text("Login"),
                    leading: IconButton(
                      onPressed: () async {
                        if (await popScreen(state)) {
                          Navigator.pop(context);
                        }
                      },
                      icon: const Icon(Icons.arrow_back),
                      splashRadius: 23,
                    ),
                  ),
                  body: Builder(
                    builder: (_) {
                      return Center(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: FormBuilder(
                              key: _formKey,
                              child: Builder(builder: (context) {
                                if (state is LoginErrorState) {
                                  if (state.exception is FormFieldsException) {
                                    for (var error in (state.exception
                                            as FormFieldsException)
                                        .errors
                                        .entries) {
                                      _formKey.currentState?.invalidateField(
                                        name: error.key,
                                        errorText: error.value,
                                      );
                                    }
                                  }
                                }

                                return Column(
                                  children: [
                                    Builder(builder: (context) {
                                      if (state is LoginErrorState) {
                                        if (state.exception
                                            is FormGeneralException) {
                                          return Column(
                                            children: [
                                              FormErrorWidget(
                                                (state.exception
                                                        as FormGeneralException)
                                                    .message,
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              )
                                            ],
                                          );
                                        }
                                      }
                                      return Container();
                                    }),
                                    FormBuilderTextField(
                                      name: 'email',
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Email',
                                      ),
                                      textInputAction: TextInputAction.next,
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(context),
                                        FormBuilderValidators.email(context),
                                      ]),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    FormBuilderTextField(
                                      name: 'password',
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Password',
                                      ),
                                      obscureText: true,
                                      textInputAction: TextInputAction.done,
                                      onSubmitted: (_) {
                                        if (state is! AuthLoadingState) {
                                          submitForm(context);
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    MaterialButton(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      onPressed: () {
                                        if (state is! LoginLoadingState) {
                                          submitForm(context);
                                        }
                                      },
                                      child: (state is LoginLoadingState)
                                          ? const Center(
                                              child: SizedBox(
                                                height: 15,
                                                width: 15,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeWidth: 2,
                                                ),
                                              ),
                                            )
                                          : const SizedBox(
                                              width: double.infinity,
                                              child: Text(
                                                'Login',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                    ),
                                    OutlinedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterScreen(),
                                          ),
                                        );
                                      },
                                      child: const SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          'Sign Up',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
