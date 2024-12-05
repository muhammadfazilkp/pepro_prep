import 'package:education_media/widgets/pdf_fullscreen_widget.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// class PdfViewPage extends StatelessWidget {
//   final String pdfUrl;

//   const PdfViewPage({Key? key, required this.pdfUrl}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("PDF Viewer")),
//       body: SfPdfViewer.network(
//         pdfUrl,
//         canShowScrollHead: true,
//         canShowScrollStatus: true,
//       ),
//     );
//   }
// }


Widget pdfView(BuildContext context, String pdfUrl, String fileName) {
  return GestureDetector(
    onTap: () {
      // Navigate to the full-screen PDF view
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FullScreenPdfView(pdfUrl: pdfUrl),
        ),
      );
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // PDF icon
        Icon(
          Icons.picture_as_pdf,
          size: 45,
          color: Colors.red,
        ),
        const SizedBox(height: 8.0),
        // PDF file name
        Text(
          fileName,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );}

  
