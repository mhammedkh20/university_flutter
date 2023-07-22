import 'package:flutter/material.dart';
import 'package:university_app/controllers/home_api_controller.dart';
import 'package:university_app/models/links.dart';
import 'package:university_app/widgets/links.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Links extends StatefulWidget {
  const Links({ Key? key , required this.subjectId}) : super(key: key);
  final int subjectId ;

  @override
  State<Links> createState() => _LinksState();
}

class _LinksState extends State<Links> {
   late Future<List<LinksModel>> _future;
  List<LinksModel> _links = <LinksModel>[];

  @override
  void initState() {
    super.initState();
    _future = HomeApiController().getLinks(widget.subjectId.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
       appBar:  AppBar(
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
          title: const Text('الروابط  ',style: TextStyle(fontFamily: 'Droid'),),
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


        body: Padding(
          padding: const EdgeInsets.only(top:30.0),
          child: FutureBuilder<List<LinksModel>>(
            future: _future,
            builder: (context, snapshot) {

               if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        else if (snapshot.hasData && snapshot.data!.isNotEmpty){
           _links = snapshot.data ??[];
              return ListView.builder(

                itemCount: _links.length,
                itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(height: 10.h,),
                     LinksWidget(link: _links[index].name , res: _links[index].res,),
                  ],
                );
              },);

        }
        else {
 return Column(
              mainAxisAlignment: MainAxisAlignment.center,
             // crossAxisAlignment: CrossAxisAlignment.center,
                      children:  [
                        Image.asset('images/nodata.jpg', height: 250.h, width: 250.w,),
                        Center(
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
      ),
    );
  }
}