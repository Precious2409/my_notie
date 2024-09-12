import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

enum MenuAction { logout }

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<MenuAction>(
            itemBuilder: (context){
              return const[
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Logout'),
              ),
              ];
            },
            onSelected: (value) async {
              switch (value)  {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout){
                   await FirebaseAuth.instance.signOut();
                   Navigator.of(context).pushNamedAndRemoveUntil(
                       '/login/',
                           (_) => false
                   );
                  }
              }
            },
          )
        ],
        title: const Text('My Notie'),
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context){
  return showDialog<bool>(
      context: context,
      builder: (context){
        return AlertDialog(
          title: const Text('Log out'),
          content: const Text('Are you sure you want to sign out ?') ,
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.of(context).pop(false);
                },
                child: const Text('No')
            ),
            TextButton(
                onPressed: (){
                  Navigator.of(context).pop(true);
                },
                child: const Text('Yes')
            )
          ],
        );
      }
  ).then((value) => value ?? false);
}

// I stopped at 12:50:19  
