import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/univ_screen.dart';

class SuccessCode extends StatefulWidget {
  const SuccessCode({Key? key}) : super(key: key);

  @override
  _SuccessCodeState createState() => _SuccessCodeState();
}

class _SuccessCodeState extends State<SuccessCode> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          automaticallyImplyLeading: false,
          centerTitle: true,
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
        body: Column(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width - 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.check_circle_outline,
                      color: Color(0xff2D475F),
                      size: 60,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'تمت العملية بنجاح',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff2D475F)),
                    ),
                    Text(
                      'شكرا لاستخدامك تطبيق موسوعتي الجامعية',
                      style: TextStyle(fontSize: 12, color: Color(0xff2D475F)),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              width: double.infinity,
              height: 45,
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UniversitiesScreen(),
                    ),
                  );
                },
                child: Container(
                  child: const Center(
                      child: Text(
                    'عودة الى الصفحة الرئيسية',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                      //you can set more BoxShadow() here
                    ],
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        Color(0xff2D475F),
                        Color(0xff3AA8F2),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
