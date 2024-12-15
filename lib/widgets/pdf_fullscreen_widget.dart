import 'dart:io';

import 'package:flutter/material.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class FullScreenPdfView extends StatefulWidget {
  final String pdfUrl;

  const FullScreenPdfView({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  State<FullScreenPdfView> createState() => _FullScreenPdfViewState();
}

class _FullScreenPdfViewState extends State<FullScreenPdfView> {
  void _disableScreenshot()async{
    bool result= await noscreenshot.screenshotOff();
    print('$result');
  }

  final noscreenshot=NoScreenshot.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _disableScreenshot();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF Viewer"),
        centerTitle: true,
      ),
      body: SfPdfViewer.network(
        widget.pdfUrl,
        canShowScrollHead: true,
        canShowScrollStatus: true,
      ),
    );
  }
}
