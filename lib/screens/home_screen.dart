import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_jwt_auth_example/blocs/auth/auth_bloc.dart';
import 'package:flutter_jwt_auth_example/screens/login/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("JWT Auth Example"),
            actions: [
              (state is AuthAuthenticatedState)
                  ? IconButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(AuthLogoutEvent());
                      },
                      splashRadius: 23,
                      icon: const Icon(
                        Icons.logout,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      splashRadius: 23,
                      icon: const Icon(
                        Icons.login,
                      ),
                    ),
            ],
          ),
          body: Center(
            child: Text(
              (state is AuthAuthenticatedState)
                  ? state.user.fullName()
                  : 'Not Authenticated',
            ),
          ),
        );
      },
    );
  }
}
