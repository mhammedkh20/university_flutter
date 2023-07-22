import 'package:flutter/material.dart';
import 'package:open_file_safe/open_file_safe.dart';

import 'package:university_app/cache/widgets/saved_pdf_card.dart';

import '../../screens/SummaryPDF.dart';
import '../../widgets/video/url_video_player.dart';

class FuturePDFCard extends StatelessWidget {
  final Future<String?> filePath;
  final VoidCallback onTapDelete;
  final String pdfName;
  final String url;
  final String imgPath;
  final String size;
  final bool isPdf;

  const FuturePDFCard(
      {Key? key,
      required this.filePath,
      required this.onTapDelete,
      required this.pdfName,
      required this.url,
      required this.imgPath,
      required this.size,
      required this.isPdf})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
        future: filePath,
        builder: (context, snapshot) {
          return SavedPDFCard(
            name: pdfName,
            onTapDelete: onTapDelete,
            onTapCard: () {
              isPdf
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SummaryPDF(
                            res: url, name: pdfName, path: snapshot.data),
                      ))
                  : OpenFile.open(snapshot.data);
            },
            imgPath: imgPath,
            size: size,
          );
        });
  }
}

class FutureVideoCard extends StatelessWidget {
  final Future<String?> filePath;
  final VoidCallback onTapDelete;
  final String pdfName;
  final String url;
  final String imgPath;
  final String size;

  const FutureVideoCard(
      {Key? key,
      required this.filePath,
      required this.onTapDelete,
      required this.pdfName,
      required this.url,
      required this.imgPath,
      required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
        future: filePath,
        builder: (context, snapshot) {
          return SavedPDFCard(
            name: pdfName,
            onTapDelete: onTapDelete,
            onTapCard: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PlayerWidget(
                        url: url, name: pdfName, path: snapshot.data),
                  ));
            },
            imgPath: imgPath,
            size: size,
          );
        });
  }
}
