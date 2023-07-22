
import 'package:flutter/material.dart';
import 'package:university_app/controllers/home_api_controller.dart';
import 'package:university_app/models/form.dart';
import 'package:university_app/widgets/forms.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/functions.dart';

class FormsScreen extends StatefulWidget {
  const FormsScreen({Key? key, required this.subjectId}) : super(key: key);
  final int subjectId;

  @override
  State<FormsScreen> createState() => _FormsScreenState();
}

class _FormsScreenState extends State<FormsScreen> {
  late Future<List<FormModel>> _future;
  List<FormModel> _form = <FormModel>[];

  @override
  void initState() {
    super.initState();
    _future = HomeApiController().getFormSample(widget.subjectId.toString(), context);
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
            'النماذج  ',
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
        body: FutureBuilder<List<FormModel>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                _form = snapshot.data ?? [];
                return OrientationBuilder(
                  builder: (BuildContext context, Orientation orientation) {
                    bool iPortrait=orientation==Orientation.portrait;

                    return GridView.builder(
                      padding:
                      EdgeInsets.only(left: 15.w, right: 15.w, top: 45.h),
                      itemCount: _form.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: iPortrait?2:4,
                        crossAxisSpacing: 20.w,
                        mainAxisSpacing: 10,
                        childAspectRatio: 6 / 7,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return FormsWidget(
                          formModel: _form[index],
                          imagepath: 'images/pdf.png',
                        );
                      },
                    );
                  },
                );
              } else {
                return  Column(
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
