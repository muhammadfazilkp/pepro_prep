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
  final mediaQuery = MediaQuery.of(context);
  final double height = mediaQuery.size.height * 0.5; // 60% of screen height
  final double width = mediaQuery.size.width * 0.9; // 90% of screen width

  return Center(
    child: Container(
      padding: EdgeInsets.all(16.0), // Add padding around the widget
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8.0,
            offset: Offset(0, 4), // Shadow offset
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "PDF View",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            height: height,
            width: width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
              child: SfPdfViewer.network(
                pdfUrl,
                canShowScrollHead: true,
                canShowScrollStatus: true,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
