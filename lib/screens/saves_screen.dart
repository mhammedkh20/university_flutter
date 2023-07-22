import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:university_app/cache/widgets/video/video_list.dart';


import '../cache/widgets/book/book_list.dart';
import '../cache/widgets/form/form_list.dart';
import '../cache/widgets/lecture/lecture_list.dart';
import '../cache/widgets/sound/audio_screen.dart';
import '../cache/widgets/summary/summary_list.dart';


class SavesScreen extends StatefulWidget {
  const SavesScreen({Key? key}) : super(key: key);

  @override
  _SavesScreenState createState() => _SavesScreenState();
}

class _SavesScreenState extends State<SavesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            " المحفوظات",
            style: TextStyle(fontFamily: 'Droid'),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color(0xff2D475F),
                    Color(0xff3AA8F2),
                  ]),
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: const [
              Tab(text: 'الكتب'),
              Tab(text: 'الملخصات'),
              Tab(text: 'النماذج'),
              Tab(text: 'الأصوات'),
              Tab(text: 'الفيديوهات'),
              Tab(text: 'المحاضرات'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            BookList(),
            SummaryList(),
            FormList(),
            AudioCacheScreen(),
            VideoList(),
            LectureList()
          ],
        ),
      ),
    );
  }
}

