import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cache/cache_file/book_cache.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SummaryPDF extends StatefulWidget {
  const SummaryPDF({
    Key? key,
    required this.res,
    required this.name,
    this.path,
  }) : super(key: key);

  final String res;
  final String name;

  // final int id;

  final String? path;

  @override
  State<SummaryPDF> createState() => _SummaryPDFState();
}

class _SummaryPDFState extends State<SummaryPDF> {
// late  PdfViewerController _pdfViewerController;
  final StreamController<String> _pageCountController =
      StreamController<String>();
  final Completer<PDFViewController> _pdfViewController =
      Completer<PDFViewController>();

  // late Future<FileInfo?> fileInfo;
  @override
  void initState() {
    // _pdfViewerController = PdfViewerController();
    super.initState();
    // fileInfo=PDFCacheManager.instance.getFileFromCache(widget.res);
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    PDF pdf = PDF(
      enableSwipe: true,
      autoSpacing: false,
      pageFling: true,
      onPageChanged: (int? current, int? total) =>
          _pageCountController.add('${current! + 1} - $total'),
      onViewCreated: (PDFViewController pdfViewController) async {
        _pdfViewController.complete(pdfViewController);
        final int currentPage = await pdfViewController.getCurrentPage() ?? 0;
        final int? pageCount = await pdfViewController.getPageCount();
        _pageCountController.add('${currentPage + 1} - $pageCount');
      },
    );
    if (widget.path == null) {
      if (kDebugMode) {
        print('link!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
      }

      body = pdf.cachedFromUrl(
        widget.res,
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
        //  controller: _pdfViewerController,
      );
    } else {
      if (kDebugMode) {
        print('cache@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ${widget.path!}');
      }
      body = pdf.fromPath(widget.path!);
    }

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FutureBuilder<PDFViewController>(
              future: _pdfViewController.future,
              builder: (_, AsyncSnapshot<PDFViewController> snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return Container(
                    width: 80,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: TextField(
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration:  InputDecoration(

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        enabledBorder:OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        hintText: 'الانتقال ل',
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      onChanged: (String value) async {
                        var pageIndex = int.tryParse(value.trim());

                        if (pageIndex is int) {
                          pageIndex--;
                          final PDFViewController pdfController =
                              snapshot.data!;
                          final int numberOfPages =
                              await pdfController.getPageCount() ?? 0;

                          print('page index $pageIndex count $numberOfPages');
                          if (pageIndex >= 0 && pageIndex < numberOfPages) {
                            await pdfController.setPage(pageIndex);

                          }
                        }
                      },
                    ),
                  );
                }
                return SizedBox();
              }),
          StreamBuilder<String>(
              stream: _pageCountController.stream,
              builder: (_, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  print('Stream is ${snapshot.data}');
                  return Center(
                    child: Container(
                      //  padding: EdgeInsets.only(right: 5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 2), // changes position of shadow
                          ),
                        ],
                        //    color: Colors.blue[900],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          snapshot.data!,
                          style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox();
              }),
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: Text(
          widget.name,
          style: const TextStyle(fontFamily: 'Droid'),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xff2D475F), Color(0xff3AA8F2)])),
        ),
      ),
      body: body,
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _pdfViewController.future,
        builder: (_, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FloatingActionButton(
                  //backgroundColor: Colors.blue[900],
                  heroTag: '-',
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[
                            Color(0xff2D475F),
                            Color(0xff3AA8F2),
                          ],
                        ),
                        shape: BoxShape.circle),
                    child: const Center(
                      child: Text(
                        '-',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 23),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    final PDFViewController pdfController = snapshot.data!;
                    final int currentPage =
                        (await pdfController.getCurrentPage())! - 1;
                    if (currentPage >= 0) {
                      await pdfController.setPage(currentPage);
                    }
                  },
                ),
                FloatingActionButton(
                  backgroundColor: Colors.blue[900],
                  heroTag: '+',
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[
                            Color(0xff2D475F),
                            Color(0xff3AA8F2),
                          ],
                        ),
                        shape: BoxShape.circle),
                    child: const Center(
                      child: Text(
                        '+',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 23),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    final PDFViewController pdfController = snapshot.data!;
                    final int currentPage =
                        (await pdfController.getCurrentPage())! + 1;
                    final int numberOfPages =
                        await pdfController.getPageCount() ?? 0;
                    if (numberOfPages > currentPage) {
                      await pdfController.setPage(currentPage);
                    }
                  },
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
