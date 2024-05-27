// ignore_for_file: use_super_parameters, use_build_context_synchronously, unused_import

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
  runApp(const DeleteRecordPage());
}*/

class DeleteRecordPage extends StatefulWidget {
  const DeleteRecordPage({Key? key}) : super(key: key);

  @override
  State<DeleteRecordPage> createState() => _DeleteRecordPageState();
}

class _DeleteRecordPageState extends State<DeleteRecordPage> {
  final TextEditingController _asinController = TextEditingController();
  
  Future<bool> _recordAlreadyExists(String asin) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("products")
          .where('asin', isEqualTo: asin)
          .get();
      return querySnapshot.docs.isNotEmpty; // will return true if a document exists.
    } catch (e) {
      print("Error checking product existence: $e");
      return false;
    }
  }

  Future<void> _deleteRecord(BuildContext context) async {
    String asin = _asinController.text;
    bool recordExists = await _recordAlreadyExists(asin);

    if (recordExists) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("products")
          .where('asin', isEqualTo: asin)
          .limit(1)
          .get();

          DocumentSnapshot doc = querySnapshot.docs.first;

      try {

        DocumentReference docRef = FirebaseFirestore.instance.collection('products').doc(doc.id);
        await docRef.delete();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Record deleted successfully")),
         );

      } catch(e) {
        print("Error deleting, $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error adding record: $e")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("ASIN doesn't exist.")),
        );
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
              "Stock Manager",
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
                      style: TextStyle(
                        fontFamily: 'Verdana',
                        fontSize: 25,
                        ),
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
                      onPressed: () => _deleteRecord(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black, 
                        foregroundColor: Colors.blue, 
                        textStyle: const TextStyle(fontFamily: 'Verdana'),
                        shadowColor: Colors.black,
                        shape: const LinearBorder()
                        ),
                      child: const Text("Delete ASIN"),
                    ),
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
