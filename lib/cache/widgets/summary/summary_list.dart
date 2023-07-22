import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:university_app/cache/cache_file/summary_cache.dart';
import 'package:university_app/cache/controller/hive_provider.dart';
import 'package:university_app/cache/widgets/fab.dart';
import 'package:university_app/models/cache/summary/summary.dart';

import '../../../widgets/no_cache.dart';
import '../future_pdf_card.dart';
import 'package:path/path.dart'as p;



class SummaryList extends StatefulWidget {
  const SummaryList({Key? key}) : super(key: key);

  @override
  State<SummaryList> createState() => _SummaryListState();
}

class _SummaryListState extends State<SummaryList> {
  @override
  Widget build(BuildContext context) {
    final hiveProvider= Provider.of<HiveProvider>(context);
    return FutureBuilder<Box<SummaryModel>?>(
      future: hiveProvider.openSummaryBox(),
      builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        }else if (snapshot.data==null){
          return const NoCacheFound(resType: 'ملخصات');
        }else{
          Box<SummaryModel>? temp=snapshot.data;
          return ValueListenableBuilder<Box<SummaryModel>>(
            valueListenable: temp!.listenable(),
            builder: (context, box, _) {
              List<SummaryModel> summaries = box.values.toList();
              return Padding(
                padding: const EdgeInsets.all(20),
                child:summaries.isEmpty
                    ? const NoCacheFound(resType: 'ملخصات')
                    : Scaffold(
                      body: ListView.separated(
                        itemCount: summaries.length,
                        itemBuilder: (BuildContext context, int index) {
                          String url = summaries[index].res;
                          String pdfName = summaries[index].name;


                          return FuturePDFCard(
                            isPdf: summaries[index].isPdf,
                            filePath: CacheSummary().getFilePath(summaries[index].id,p.extension(url).toLowerCase()),
                            onTapDelete: () async{
                              await CacheSummary().deleteSummaryModel(summaries[index]);
                            },
                            url: url,
                            pdfName: pdfName,
                            imgPath: 'images/pw.png',
                            size: summaries[index].size
                            ,);
                        },
                        separatorBuilder: (_, _i) => const SizedBox(
                          height: 15,
                        ),
                      ),
                  floatingActionButton: DeleteAllButton(
                    onTapDeleteAll: ()async{
                      final Box<SummaryModel>? box=await hiveProvider.openSummaryBox();
                      if(box!=null) {
                        CacheSummary().removeAllCached(box);
                      }
                    },
                  ),
                    ),
              );
            },
          );
        }
      }
    );
  }
}
