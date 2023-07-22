


import 'package:hive_flutter/hive_flutter.dart';
part 'summary.g.dart';

@HiveType(typeId: 2)
class SummaryModel extends HiveObject{
  @HiveField(0)
  late int id ;
  @HiveField(1)
  late String name ;
  @HiveField(2)
  late int resource_type_id;
  @HiveField(3)
  late String  res;
  @HiveField(4)
  late String created_at;
  @HiveField(5)
   late String updated_at;
  @HiveField(6)
  late String size;
  @HiveField(7)
  late bool isPdf;

}