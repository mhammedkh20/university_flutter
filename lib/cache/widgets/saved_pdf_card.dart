
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SavedPDFCard extends StatelessWidget {
  final String name;
  final VoidCallback onTapDelete;
  final VoidCallback onTapCard;
  final String imgPath;
  final String size;

  const SavedPDFCard(
      {Key? key,
        required this.name,
        required this.onTapDelete,
        required this.onTapCard,
        required this.imgPath,
        required this.size
      })
      : super(key: key);

  // Future<Uint8List> generateThumbnail(String pdfPath, int pageNumber) async {
  //   // Load the PDF file
  //   final document = await PdfDocument.openFile(pdfPath);
  //
  //   // Get the specified page
  //   final page = await document.getPage(pageNumber);
  //
  //   // Render the page as an image
  //   final pageImage = await page.render(fullWidth: page.width, fullHeight: page.height);
  //
  //   // Create a thumbnail from the rendered image
  //   final thumbnail = await pageImage.createImageDetached();
  //
  //   // Convert the thumbnail to a Uint8List
  //   final thumbnailData = await thumbnail.toByteData(format: ImageByteFormat.png);
  //   final thumbnailBytes = Uint8List.view(thumbnailData!.buffer);
  //
  //   // Return the thumbnail image data
  //   return thumbnailBytes;
  // }






  @override
  Widget build(BuildContext context) {
   return Container(
     decoration: BoxDecoration(
         color: Colors.lightBlue[50],
       borderRadius: BorderRadius.all(Radius.circular(25))
     ),
     child: ListTile(

       dense: true,
        onTap:onTapCard ,
        leading:Image.asset(
          imgPath,
          // height: 65.h,
        ),
        title:Text(
          name,
          style: TextStyle(
            color: const Color(0xff377198),
            fontSize: 12.spMin,
            fontFamily: 'Droid',
            fontWeight: FontWeight.bold,
          ),
          // textAlign: TextAlign.center,
        ) ,
        subtitle: Text(size,style:
        TextStyle(
          color: const Color(0xff377198),
          fontSize: 12.spMin,
          fontFamily: 'Droid',
          fontWeight: FontWeight.w200,
        ),),
        trailing: IconButton(
            onPressed: () {
              onTapDelete();
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            )),
      ),
   );
    // return InkWell(
    //   onTap:onTapCard,
    //   child:Container(
    //     padding: const EdgeInsets.all(8),
    //     decoration: BoxDecoration(
    //       color: Colors.white,
    //       borderRadius: BorderRadius.circular(15),
    //     ),
    //     child: Row(
    //       children: [
    //         Image.asset(
    //           imgPath,
    //           height: 65.h,
    //         ),
    //         const SizedBox(
    //           width: 10,
    //         ),
    //         Expanded(
    //           child: Text(
    //             name,
    //             style: TextStyle(
    //               color: const Color(0xff377198),
    //               fontSize: 12.sp,
    //               fontFamily: 'Droid',
    //               fontWeight: FontWeight.bold,
    //             ),
    //             // textAlign: TextAlign.center,
    //           ),
    //         ),
    //         const SizedBox(width: 5,),
    //         Text(size,style: const TextStyle(fontFamily: 'Droid',fontSize: 11),),
    //         const SizedBox(width: 5,),
    //         IconButton(
    //             onPressed: () {
    //               onTapDelete();
    //             },
    //             icon: const Icon(
    //               Icons.delete,
    //               color: Colors.red,
    //             )),
    //       ],
    //     ),
    //   ) ,
    // );
  }
}
