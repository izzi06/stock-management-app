// ignore_for_file: use_super_parameters, use_build_context_synchronously, avoid_web_libraries_in_flutter, unused_import

// ignore: duplicate_ignore
// ignore: unused_import
import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

/* void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBrmANvNANnXvtm2NneEhOgQ2d7H5m4ZYs",
      projectId: "amozo-stock-manager",
      messagingSenderId: "1012122325118",
      appId: "1:1012122325118:web:e38d657d1ab35e53da482f",
    ),
  );
  runApp(const DisplayRecordsPage());
}*/

class DisplayRecordsPage extends StatefulWidget {
  const DisplayRecordsPage({Key? key}) : super(key: key);

  @override
  State<DisplayRecordsPage> createState() => _DisplayRecordsPageState();
}

 class _DisplayRecordsPageState extends State<DisplayRecordsPage> {
  final TextEditingController _asinController = TextEditingController();
  String outputText = '';
  Future<bool> _recordAlreadyExists(String asin) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("products")
          .where('asin', isEqualTo: asin)
          .get();
      return querySnapshot.docs.isNotEmpty; // will return true if a document exists.
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error showing stock: $e")),
            );
      return false;
    }
  }

  Future<void> _displayRecord(BuildContext context) async {
    String asin = _asinController.text;
    bool asinExists = await _recordAlreadyExists(asin);

    if (asinExists) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("products")
          .where('asin', isEqualTo: asin)
          .limit(1)
          .get();
      DocumentSnapshot doc = querySnapshot.docs.first;
      
      try {
        String stockValue = doc.get('stock').toString();
        setState(() {
          outputText = "Stock => $stockValue";
        });
      } catch(e) {
         setState(() {
           outputText = "Problem with the code -> $e";
         });
      }

    }else {
      setState(() {
        outputText = "ASIN not found";
      });
    }
   
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor:  Colors.blue,
        appBar: AppBar(
          leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
          title: const Center(
            child: Text(
              "Amozo Stock Manager",
              style: TextStyle(
                fontSize: 25,
                color: Colors.blue,
                fontFamily: 'Verdana',
              ),
            ),
          ),
          backgroundColor: Colors.black,
        ),
        body: Builder(
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    const Text(
                      "Enter product ASIN",
                      style: TextStyle(fontFamily: 'Verdana', fontSize: 25),
                    ),
                    TextField(
                      controller: _asinController,
                      decoration: const InputDecoration(
                        hintText: "B0D26C7R2T",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20), // Reduced height for better spacing
                   /* const Text(
                      "Enter new stock value",
                      style: TextStyle(fontFamily: 'Verdana'),
                    ),
                    TextField(
                      controller: _stockController,
                      decoration: const InputDecoration(
                        hintText: "Any number you want!",
                        border: OutlineInputBorder(),
                      ),
                    ),*/
                    const SizedBox(height: 20), // Reduced height for better spacing
                    ElevatedButton(
                      onPressed: () => _displayRecord(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black, 
                        foregroundColor: Colors.blue, 
                        textStyle: const TextStyle(fontFamily: 'Verdana'),
                        shadowColor: Colors.black,
                        shape: const LinearBorder()
                        ),
                      child: const Text("Show Stock"),
                    ),
                    const SizedBox(height: 200),
                    Text(outputText, style: const TextStyle(fontFamily: 'Verdana', fontSize: 25),),
                   ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
