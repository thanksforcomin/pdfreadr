import 'package:flutter/material.dart' hide Intent;
import 'dart:io';
import 'package:file_picker/file_picker.dart';

import "pdf_window.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 255, 151, 81)),
          useMaterial3: true,
        ),
        home: const LobbyPage());
  }
}

class LobbyPage extends StatefulWidget {
  const LobbyPage({super.key});

  @override
  State<LobbyPage> createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  late Set<String> filepaths;

  @override
  void initState() {
    super.initState();
    filepaths = new Set<String>();
    //filepaths.add("test");
  }

  String strip_file_name(String path) {
    return path.split('/').last;
  }

  Widget get_list_entry_container(String name) {
    return GestureDetector(
        onTap: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (contextPP) => PdfWindows(filepath: name),
              ));
        },
        child: Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(10.0),
          height: 100,
          alignment: Alignment.center,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0.5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                )
              ],
              color: const Color.fromARGB(255, 26, 22, 21)),
          child: Text(strip_file_name(name),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  overflow: TextOverflow.ellipsis),
              textAlign: TextAlign.center),
        ));
  }

  List<Widget> get_books_list() {
    List<Widget> list = new List<Widget>.empty(growable: true);

    for (String i in filepaths) {
      list.add(get_list_entry_container(i));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topCenter,
                stops: [
              0.0,
              1.0
            ],
                colors: [
              Color.fromARGB(255, 229, 173, 133),
              Color.fromARGB(255, 238, 214, 204)
            ])),
        child: Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              actions: <Widget>[
                TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.only(right: 20.0),
                    ),
                    onPressed: () async {
                      await FilePicker.platform
                          .pickFiles()
                          .then((FilePickerResult? result) {
                        if (result != null) {
                          File file =
                              File(result.files.single.path!.toString());
                          String filepath = file.absolute.path.toString();
                          setState(() => filepaths.add(filepath));
                          print("filepath: $filepath");

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (contextPP) =>
                                    PdfWindows(filepath: filepath),
                              ));
                        }
                      });
                    },
                    child: const Text(
                      "Pick File",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.center,
                    ))
              ],
            ),
            body: ListView(
              reverse: true,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(10.0),
              children: get_books_list(),
            )));
  }
}
