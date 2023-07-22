import 'package:hive/hive.dart';
part 'video.g.dart';
@HiveType(typeId: 5)
class VideoModel extends HiveObject{
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
}