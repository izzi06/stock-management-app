// ignore_for_file: use_key_in_widget_constructors

import 'dart:js_interop';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'add_record_page.dart';
import 'update_record_page.dart';
import 'delete_record_page.dart';
import 'display_records_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBrmANvNANnXvtm2NneEhOgQ2d7H5m4ZYs', 
      appId: "1:1012122325118:web:e38d657d1ab35e53da482f", 
      messagingSenderId: "1012122325118",
       projectId: "amozo-stock-manager")
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stock Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/add': (context) => const AddRecordPage(),
        '/update': (context) => const UpdateRecordPage(),
        '/delete': (context) => const DeleteRecordPage(),
        '/display': (context) => const DisplayRecordsPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stock Manager"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add');
              },
              child: const Text("Add Record"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/update');
              },
              child: const Text("Update Record"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/delete');
              },
              child: const Text("Delete Record"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/display');
              },
              child: const Text("Display Records"),
            ),
          ],
        ),
      ),
    );
  }
}
