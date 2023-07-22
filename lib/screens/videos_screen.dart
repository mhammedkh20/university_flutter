import 'package:flutter/material.dart';
import 'package:university_app/controllers/home_api_controller.dart';
import 'package:university_app/models/video.dart';
import 'package:university_app/widgets/videos.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class VideosScreen extends StatefulWidget {
  const VideosScreen({ Key? key  , required this.subjectId}) : super(key: key);
  final int subjectId;

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
   late Future<List<VideoModel>> _future;
  List<VideoModel> _video = <VideoModel>[];

  @override
  void initState() {
    
    super.initState();
    _future = HomeApiController().getVideo(widget.subjectId.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
          title: const Text('الفيديوهات  ',style: TextStyle(fontFamily: 'Droid'),),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[

                Color(0xff2D475F),Color(0xff3AA8F2)
              ])
           ),
       ),
        ),

        body: FutureBuilder<List<VideoModel>>(
          future: _future,
          builder: (context, snapshot) {
             if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        else if (snapshot.hasData && snapshot.data!.isNotEmpty){
          _video = snapshot.data ??[];
            return OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                bool isPortrait=orientation==Orientation.portrait;
                return GridView.builder(
                  padding:  EdgeInsets.only(left: 15.w, right: 15.w, top: 45.h),
                  itemCount: _video.length,
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isPortrait?2:3,
                    crossAxisSpacing: 20.w,
                    mainAxisSpacing: 10,
                    childAspectRatio:6/7,
                  ),
                  itemBuilder: (BuildContext context, int index){
                    return  VideosWidget(
                      imagepath: 'images/vd.png' ,
                      model: _video[index],
                    );
                  },
                );
              },
            );

        }
        else {
           return Column(
              mainAxisAlignment: MainAxisAlignment.center,
             // crossAxisAlignment: CrossAxisAlignment.center,
                      children:  [
                        Image.asset('images/nodata.jpg', height: 250.h, width: 250.w,),
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
          }
        ),


      ),
    );
  }
}