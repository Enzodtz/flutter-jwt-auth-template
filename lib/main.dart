import 'dart:io';

import 'package:axalta/views/home_view.dart';
import 'package:axalta/views/login/bloc/login_bloc.dart';
import 'package:axalta/views/login/login_screen.dart';
import 'package:axalta/views/weigihing/pigment_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:axalta/views/splash_screen.dart';

import 'blocs/auth/auth_bloc.dart';
import 'constants/routes.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        title: 'Home',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            // colorScheme: const ColorScheme.dark(),
            // primarySwatch: Colors.blue,
            ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            // return const HomeView();

            if (state is LoginSuccessState) {
              return const HomeView();
            } else {
              return LoginScreen();
            }
          },
        ),
        routes: {
          homeRoute: (context) => const HomeView(),
          splashRoute: (context) => const SplashScreen(),
          loginRoute: (context) => LoginScreen(),
          pigmentRoute: (context) => const PigmentView(),
        },
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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
