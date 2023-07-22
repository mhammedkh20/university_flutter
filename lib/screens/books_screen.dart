import 'package:flutter/material.dart';
import 'package:university_app/controllers/home_api_controller.dart';
import 'package:university_app/models/book.dart';
import 'package:university_app/widgets/books.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/functions.dart';


class BooksScreen extends StatefulWidget {
  const BooksScreen({Key? key, required this.subjectId}) : super(key: key);
  final int subjectId;

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  late Future<List<BookModel>> _future;
  late Future<String?> filePath;

  List<BookModel> _books = <BookModel>[];

  @override
  void initState() {
    super.initState();
     _future =  HomeApiController().getBooks(widget.subjectId.toString(),context);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          centerTitle: true,
          title: const Text(
            'الكتب والمراجع',
            style: TextStyle(fontFamily: 'Droid'),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xff2D475F), Color(0xff3AA8F2)],
              ),
            ),
          ),
        ),
        body: FutureBuilder<List<BookModel>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                _books = snapshot.data ?? [];
                return _books.isNotEmpty ?OrientationBuilder(
                  builder: (BuildContext context, Orientation orientation) {
                    bool iPortrait=orientation==Orientation.portrait;

                    return GridView.builder(
                      padding: EdgeInsets.only(
                        left: 15.w,
                        right: 15.w,
                        top: 20.h,
                        bottom: 10,
                      ),
                      itemCount: _books.length,
                      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: iPortrait?2:4,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15),
                      itemBuilder: (BuildContext context, int index) {
                        return BooksWidget(
                          bookModel: _books[index],
                          imagepath: 'images/pdf.png',
                        );
                      },
                    );
                  },
                ):Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/nodata.jpg',
                      height: 250.h,
                      width: 250.w,
                    ),
                    const Center(
                      child: Text(
                        'سيتم إضافتها قريباً ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return const SizedBox();
              }
            }),
      ),
    );
  }
}
