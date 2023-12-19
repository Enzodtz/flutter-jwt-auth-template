// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:axalta/blocs/auth/auth_bloc.dart';
import 'package:axalta/constants/routes.dart';
import 'package:axalta/enums/menu_action.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  double width = 320;
  double height = 40;
  Color backgroundColor = const Color.fromARGB(255, 63, 218, 245);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ana Ekran"),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogOut = await showLogOutDialog(context);

                  if (shouldLogOut) {
                    context
                        .read<AuthBloc>()
                        .add(AuthLogoutEvent()); //Logout User
                    devtools.log("Çıkış Başarılı");
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                  }
                  break;
                case MenuAction.changePassword:
                  final shouldLogOut = await showLogOutDialog(context);

                  if (shouldLogOut) {
                    context
                        .read<AuthBloc>()
                        .add(AuthLogoutEvent()); //Logout User
                    devtools.log("Çıkış Başarılı");
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                  }
                  break;
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                  value: MenuAction.logout,
                  child: Text("Şifre Değiştir"),
                ),
                PopupMenuItem(
                  value: MenuAction.logout,
                  child: Text("Çıkış"),
                )
              ];
            },
          )
        ],
      ),
      body: Column(
        children: [
          const Spacer(
            flex: 1,
          ),
          SizedBox(
              width: width, // <-- Your width
              height: height, // <-- Your height
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(pigmentRoute);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: backgroundColor,
                    // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.normal)),
                child: const Text("Pigment Tartım"),
              )),
          const Spacer(
            flex: 5,
          ),
          SizedBox(
              width: width, // <-- Your width
              height: height, // <-- Your height
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: backgroundColor,
                    // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.normal)),
                child: const Text("Ara Tartım-1"),
              )),
          const Spacer(
            flex: 5,
          ),
          SizedBox(
              width: width, // <-- Your width
              height: height, // <-- Your height
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: backgroundColor,
                    // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.normal)),
                child: const Text("Ara Tartım-2"),
              )),
          const Spacer(
            flex: 5,
          ),
          SizedBox(
              width: width, // <-- Your width
              height: height, // <-- Your height
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: backgroundColor,
                    // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.normal)),
                child: const Text("Kaba Tartım"),
              )),
          const Spacer(
            flex: 5,
          ),
          SizedBox(
              width: width, // <-- Your width
              height: height, // <-- Your height
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: backgroundColor,
                    // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.normal)),
                child: const Text("Kümülatif Çıktı"),
              )),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Kullanıcı Çıkışı"),
        content: const Text("Çıkış yapmak istediğinize emin misiniz?"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("İptal")),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Çıkış")),
        ],
      );
    },
  ).then((value) => value ?? false);
}
