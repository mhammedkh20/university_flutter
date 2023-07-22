



// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:http/http.dart';
// import 'package:university_app/controllers/home_api_controller.dart';
// import 'package:university_app/models/sound.dart';
// import 'package:university_app/utils/constants.dart';
// import 'package:university_app/widgets/voice.dart';


// class Voice extends StatefulWidget {
//   const Voice({ Key? key , required this.id }) : super(key: key);
//   final int id;
//   @override
//   State<Voice> createState() => _VoiceState();
// }

// class _VoiceState extends State<Voice> {
  
  
//    late Future<List<SoundModel>> _future;
//   List<SoundModel> _sounds = <SoundModel>[];

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _future = HomeApiController().getSound(widget.id.toString());
//   }
//   @override
//   void dispose() {
   
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//      appBar:  AppBar(
//         leading: IconButton(onPressed: (){
//           Navigator.pop(context);
//         }, icon: const Icon(Icons.arrow_back_ios)),
//       centerTitle: true,
//         title: const Text('الأصوات  ',style: TextStyle(fontFamily: 'Droid'),),
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: <Color>[
              
//               Color(0xff2D475F),Color(0xff3AA8F2)
//             ])          
//          ),        
//      ),
//       ),


//       body: Padding(
//         padding: const EdgeInsets.only(top:30.0),
//         child: FutureBuilder<List<SoundModel>>(
//           future: _future,
//           builder: (context, snapshot) {
//              if(snapshot.connectionState == ConnectionState.waiting){
//            return Center(child: CircularProgressIndicator(),);
//          }
         
//          else if(snapshot.hasData && snapshot.data!.isNotEmpty){
//             _sounds = snapshot.data ?? [];
//             return Column(
              
//               children: [
//                 Expanded(
//                   child: ListView.builder(
                   
//                     itemCount: _sounds.length,
//                     itemBuilder: (context, index) {
//                     return GestureDetector(
//                            onTap: (){
//                             print('clicked');
                        
//                            },
//                            child: Padding(
//                              padding: const EdgeInsets.all(8.0),
//                              child: VoiceWidget(name:  _sounds[index].name , link: _sounds[index].res,  ),
//                            ));
                       
                     
//                   },),

                  
//                 ),


//                 Container(
//                   height: 128.h,
//                   width: 375.w,
                
//         decoration : BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: <Color>[
              
//               Color(0xff2D475F),Color(0xff3AA8F2)
//             ]),          
//          ),     

//          child:   FutureBuilder<List<SoundModel>>(
//            future: _future,
//            builder: (context, snapshot) {
//              return ListView.builder(
//                itemCount: _sounds.length,
//                itemBuilder: (context, index){
//              if(snapshot.hasData && snapshot.data!.isNotEmpty){
//                _sounds = snapshot.data ?? [];
//                 return Column(
//                         children: [ 
//                      Text(_sounds[index].name, style: TextStyle(fontFamily: 'Droid' , fontWeight: FontWeight.bold, color: Colors.white),),
         
//                         Slider.adaptive(value: 0.0, onChanged: (value){}),
//                         IconButton(onPressed: (){}, icon: Icon(Icons.play_arrow) , color: Colors.white, iconSize: 35,)
//                       ],);

//              }else{
//                return Text('No Data');
//              }
//              });
           
//            }
//          ),
//                 //   child: Column(
//                 //     children: [ 
//                 //  Text('اسم الصوت', style: TextStyle(fontFamily: 'Droid' , fontWeight: FontWeight.bold, color: Colors.black),),

//                 //     Slider.adaptive(value: 0.0, onChanged: (value){}),
//                 //     IconButton(onPressed: (){}, icon: Icon(Icons.play_arrow) , color: Colors.white, iconSize: 35,)
//                 //   ],),
//                 )
//               ],
//             );
//           }
//           else {
//              return Center(
//               child: Column(
//                 children: const [
//                   Icon(Icons.warning, size: 80),
//                   Text(
//                     'NO DATA',
//                     style: TextStyle(
//                       color: Colors.grey,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 24,
//                     ),
//                   )
//                 ],
//               ),
//             );
//           }
//           }
//         ),
//       ),
//     );
//   }
// }