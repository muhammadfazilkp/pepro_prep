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

Widget pdfView(BuildContext context, String pdfUrl) {
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
    child: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // PDF icon
          Icon(
            Icons.picture_as_pdf,
            size: 45,
            color: Colors.red,
          ),
          const SizedBox(height: 4),
          // PDF view text
          Text(
            'View',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ],
      ),
    ),
  );
}
