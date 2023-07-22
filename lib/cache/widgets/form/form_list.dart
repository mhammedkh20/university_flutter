import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:university_app/cache/cache_file/form_cache.dart';
import 'package:university_app/cache/cache_file/form_cache.dart';
import 'package:university_app/cache/cache_file/form_cache.dart';
import 'package:university_app/cache/cache_settIngs.dart';
import 'package:university_app/cache/widgets/fab.dart';

import '../../../models/cache/book/book.dart';
import '../../../models/cache/form/form.dart';
import '../../../widgets/no_cache.dart';
import '../../cache_file/book_cache.dart';
import '../../controller/hive_provider.dart';
import '../future_pdf_card.dart';
import 'package:path/path.dart'as p;



class FormList extends StatefulWidget {
  const FormList({Key? key}) : super(key: key);

  @override
  State<FormList> createState() => _FormListState();
}

class _FormListState extends State<FormList> {

  @override
  Widget build(BuildContext context) {
    final hiveProvider = Provider.of<HiveProvider>(context);
    return FutureBuilder<Box<FormModel>?>(
      future: hiveProvider.openFormBox(),
      builder: (context, snapshot) {
        Box<FormModel>? temp=snapshot.data;
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }else{
          return ValueListenableBuilder<Box<FormModel>>(
            valueListenable: temp!.listenable(),
            builder: (context, box, _) {
              List<FormModel> forms = box.values.toList();
              return Padding(
                padding: const EdgeInsets.all(20),
                // child: context.watch<CacheModel>().cached.isEmpty
                child:forms.isEmpty
                    ? const NoCacheFound(resType: 'نماذج')
                    : Scaffold(
                      body: ListView.separated(
                        itemCount: forms.length,
                        itemBuilder: (BuildContext context, int index) {
                          String url = forms[index].res;
                          String pdfName = forms[index].name;


                          return FuturePDFCard(
                            isPdf:forms[index].isPdf ,
                            filePath: CacheForm().getFilePath(forms[index].id,p.extension(url).toLowerCase()),
                            onTapDelete: () async{
                              await CacheForm().deleteFormModel(forms[index]);
                            },
                            url: url,
                            pdfName: pdfName,
                            imgPath: 'images/pdf.png',
                            size: forms[index].size
                            ,);
                        },
                        separatorBuilder: (_, _i) => const SizedBox(
                          height: 15,
                        ),
                      ),
                  floatingActionButton: DeleteAllButton(
                      onTapDeleteAll:()async{
                        final Box<FormModel>? box=await hiveProvider.openFormBox();
                        CacheForm().removeAllCached(box!);
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
