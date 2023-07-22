
import 'package:flutter/material.dart';
import 'package:university_app/controllers/home_api_controller.dart';
import 'package:university_app/models/summary.dart';
import 'package:university_app/widgets/summary.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/functions.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({Key? key, required this.subjectId}) : super(key: key);
  final int subjectId;

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  late Future<List<SummaryModel>> _future;
  List<SummaryModel> _summary = <SummaryModel>[];

  @override
  void initState() {
    super.initState();
    _future = HomeApiController().getSummary(widget.subjectId.toString());
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
              icon: const Icon(Icons.arrow_back_ios)),
          centerTitle: true,
          title: const Text(
            'الملازم والملخصات',
            style: TextStyle(fontFamily: 'Droid'),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xff2D475F), Color(0xff3AA8F2)]),
            ),
          ),
        ),
        body: FutureBuilder<List<SummaryModel>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                _summary = snapshot.data ?? [];
                return OrientationBuilder(
                  builder: (BuildContext context, Orientation orientation) {
                    bool iPortrait=orientation==Orientation.portrait;
                    return GridView.builder(
                      padding: EdgeInsets.only(
                          left: 15.w, right: 15.w, top: 20, bottom: 5),
                      itemCount: _summary.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: iPortrait?2:4,
                          crossAxisSpacing: 20.w,
                          mainAxisSpacing: 15),
                      itemBuilder: (BuildContext context, int index) {
                        return SummaryWidget(
                          summaryModel: _summary[index],
                          imagepath: 'images/pw.png',
                        );
                      },
                    );
                  },
                );
              } else {
                return Column(
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
              }
            }),
      ),
    );
  }
}
