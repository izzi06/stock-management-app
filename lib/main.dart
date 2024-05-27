// ignore_for_file: use_key_in_widget_constructors, unused_import

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
      //  primarySwatch: Colors.black,
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
        backgroundColor: Colors.black,
        title: const Text("Stock Manager", style: TextStyle(color: Colors.blue, fontFamily: 'Verdana'),),
      ),
      backgroundColor: Colors.blue,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
             const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, 
                foregroundColor: Colors.blue, 
                textStyle: const TextStyle(fontFamily: 'Verdana'),
                shadowColor: Colors.black,
                shape: const LinearBorder()
                ),
              child: const Text("Add ASIN"),
            ),
            const SizedBox(width: 170),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/update');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, 
                foregroundColor: Colors.blue, 
                textStyle: const TextStyle(fontFamily: 'Verdana'),
                shadowColor: Colors.black,
                shape: const LinearBorder()
                ),
              child: const Text("Update ASIN"),
            ),
            const SizedBox(width: 170),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/delete');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, 
                foregroundColor: Colors.blue, 
                textStyle: const TextStyle(fontFamily: 'Verdana'),
                shadowColor: Colors.black,
                shape: const LinearBorder()
                ),
              child: const Text("Delete ASIN"),
            ),
            const SizedBox(width: 170),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/display');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, 
                foregroundColor: Colors.blue, 
                textStyle: const TextStyle(fontFamily: 'Verdana'),
                shadowColor: Colors.black,
                shape: const LinearBorder()
                ),
              child: const Text("Display ASIN"),
            ),
             const SizedBox(width: 10)
          ],
        ),
      ),
    );
  }
}
