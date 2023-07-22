import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DownloadButton extends StatefulWidget {
  final Future<String?>fileFuture;
  final VoidCallback onTapDownload;
  const DownloadButton({Key? key, required this.fileFuture, required this.onTapDownload}) : super(key: key);

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
        future: widget.fileFuture,
        builder: (_, AsyncSnapshot<String?> snapshot) {
          late Widget body;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              body =  const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
              break;
            default:
              String? path = snapshot.data;
              if (path==null) {
                body = IconButton(
                  padding: EdgeInsets.zero,
                    onPressed:(){
                      widget.onTapDownload();
                      setState(() {

                      });
                    },
                    icon: const Icon(
                      Icons.bookmark_add_outlined,
                      color: Colors.green,
                    ));
              } else {
                body = const Icon(
                  Icons.bookmark_added_rounded,
                  color: Colors.green,
                );
              }
              break;
          }
          return body;
        });
  }
}
