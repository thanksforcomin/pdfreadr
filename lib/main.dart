import 'package:flutter/material.dart' hide Intent;
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:pdfx/pdfx.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  String filepath = "assets/mit.pdf";
  late PdfControllerPinch pdfController;

  @override
  void initState() {
    super.initState();

    pdfController =
        PdfControllerPinch(document: PdfDocument.openAsset(filepath));
  }

  Future<void> onPickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      if (await file.exists()) {
        setState(() {
          filepath = file.path;
          pdfController =
              PdfControllerPinch(document: PdfDocument.openAsset(filepath));
        });
      } else {
        print("File not found");
      }
      ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              TextButton(onPressed: onPickFiles, child: const Text("Pick File"))
            ],
          ),
          body: Center(
              child: Column(
            children: [
              Expanded(
                  child: PdfViewPinch(
                controller: pdfController,
              ))
            ],
          )),
        ));
  }
}
