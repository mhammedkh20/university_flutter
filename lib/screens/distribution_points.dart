import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/home_api_controller.dart';
import '../models/distribution_points.dart';

class DistributionPoints extends StatefulWidget {
  const DistributionPoints({Key? key}) : super(key: key);

  @override
  State<DistributionPoints> createState() => _DistributionPointsState();
}

class _DistributionPointsState extends State<DistributionPoints> {
  List<DistributionPointsModel> distributionPointsList = <DistributionPointsModel>[];
  late Future<List<DistributionPointsModel>> _future;
  @override
  void initState() {
    super.initState();
    _future= HomeApiController().getDistributionPoints();
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
            'نقاط البيع',
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
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
          child: FutureBuilder<List<DistributionPointsModel>>(
            future: _future,
            builder: (context, snapshot) {
              if(snapshot.hasData&&snapshot.connectionState==ConnectionState.done){
                distributionPointsList = snapshot.data ?? [];
                print(distributionPointsList);
                return ListView.builder(
                  itemCount: distributionPointsList.length,
                  itemBuilder: ((context, index) {
                    return PointWidget(distributionPoints: distributionPointsList[index],);
                  }),
                );
              }else{
                return const Center(child: CircularProgressIndicator());
              }

            },
          ),
        ),
      ),
    );
  }
}

class PointWidget extends StatelessWidget {
  DistributionPointsModel distributionPoints;
   PointWidget({
    Key? key,
    required this.distributionPoints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String phone2=distributionPoints.phone2!=null?","+distributionPoints.phone2.toString():"";
    return Column(
      children: [
        SizedBox(height: 30.h,),

        Container(
          // height: 180.h,
          padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 15.h),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: Colors.white,
            border: Border.all(color: const Color(0xff2D475F), width: 1),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff2D475F).withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
               distributionPoints.name??'',
                style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xff2D475F),
                    fontWeight: FontWeight.bold),
              ),
              distributionPoints.phone1!=null||distributionPoints.phone2!=null?
              Row(
                children: [
                  Text(
                    'هاتف:',
                    style: TextStyle(fontSize: 14.sp, color: const Color(0xff2D475F)),
                  ),
                  Text(
                    distributionPoints.phone1??''+phone2,
                    style: TextStyle(
                        fontSize: 13.sp,
                        color: const Color(0xff2D475F),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ):SizedBox(),
              distributionPoints.email!=null?
              Row(
                children: [
                  Text('ايميل:',
                      style: TextStyle(fontSize: 14.sp, color: const Color(0xff2D475F))),
                  Text(
                    distributionPoints.email??'',
                    style: TextStyle(
                        fontSize: 13.sp,
                        color: const Color(0xff2D475F),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ):SizedBox(),
              Row(
                children: [
                  Text('العنوان:',
                      style: TextStyle(fontSize: 14.sp, color: const Color(0xff2D475F))),
                  Text(
                   distributionPoints.address??'',
                    style: TextStyle(
                        fontSize: 11.sp,
                        color: const Color(0xff2D475F),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
