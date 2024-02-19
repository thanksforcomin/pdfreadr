import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'dart:io';

class PdfWindows extends StatefulWidget {
  final String filepath;
  const PdfWindows({super.key, required this.filepath});

  @override
  State<PdfWindows> createState() => _PdfWindowsState();
}

class _PdfWindowsState extends State<PdfWindows> {
  late PdfControllerPinch pdfController;

  void initState() {
    super.initState();
    print("filepath: ${widget.filepath}");

    File file = File(widget.filepath);
    print(file.exists()!.toString());

    pdfController =
        PdfControllerPinch(document: PdfDocument.openAsset(widget.filepath));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: [
          Expanded(
              child: PdfViewPinch(
            controller: pdfController,
          ))
        ],
      )),
    );
  }
}
