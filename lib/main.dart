import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_jwt_auth_example/screens/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_jwt_auth_example/screens/splash_screen.dart';

import 'blocs/auth/auth_bloc.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        title: 'Pet Home',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            // colorScheme: const ColorScheme.dark(),
            // primarySwatch: Colors.blue,
            ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoadingState) {
              return const SplashScreen();
            } else {
              return const HomeScreen();
            }
          },
        ),
        localizationsDelegates: const [
          FormBuilderLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          // Locale('pt', ''),
          // Locale('es', ''),
          // Locale('fa', ''),
          // Locale('fr', ''),
          // Locale('ja', ''),
          // Locale('sk', ''),
          // Locale('pl', ''),
        ],
      ),
    );
  }
}
