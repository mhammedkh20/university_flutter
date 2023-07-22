import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:university_app/cache/widgets/fab.dart';

import '../../../models/cache/book/book.dart';
import '../../../widgets/no_cache.dart';
import '../../cache_file/book_cache.dart';
import '../../controller/hive_provider.dart';
import '../future_pdf_card.dart';
import 'package:path/path.dart'as p;

class BookList extends StatefulWidget {
  const BookList({Key? key}) : super(key: key);

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    final hiveProvider = Provider.of<HiveProvider>(context);
    return FutureBuilder<Box<BookModel>?>(
        future: hiveProvider.openBookBox(),
        builder: (context, snapshot) {
          Box<BookModel>? temp = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ValueListenableBuilder<Box<BookModel>>(
              valueListenable: temp!.listenable(),
              builder: (context, box, _) {
                List<BookModel> books = box.values.toList();
                return Padding(
                  padding: const EdgeInsets.all(20),
                  // child: context.watch<CacheModel>().cached.isEmpty
                  child: books.isEmpty
                      ? const NoCacheFound(resType: 'كتب')
                      : Scaffold(
                          body: ListView.separated(
                            itemCount: books.length,
                            itemBuilder: (BuildContext context, int index) {
                              String url = books[index].res;
                              String pdfName = books[index].name;
                              return FuturePDFCard(
                                isPdf: books[index].isPdf,
                                filePath:
                                    CacheBook().getFilePath(books[index].id,p.extension(url).toLowerCase()),
                                onTapDelete: () async {
                                  await CacheBook()
                                      .deleteBookModel(books[index]);
                                },
                                url: url,
                                pdfName: pdfName,
                                imgPath: 'images/pdf.png',
                                size: books[index].size,
                              );
                            },
                            separatorBuilder: (_, _i) => const SizedBox(
                              height: 15,
                            ),
                          ),
                          floatingActionButton: DeleteAllButton(
                            onTapDeleteAll: () async {
                              final Box<BookModel>? box =
                                  await hiveProvider.openBookBox();
                              CacheBook().removeAllCached(box!);
                            },
                          ),
                        ),
                );
              },
            );
          }
        });
  }
}
