
class LecturesModel{
  late int id ;
  late String name ;
  late int resource_type_id;
  late int course_id;
  late String  res;
  late String created_at;
  late String updated_at;
  late String size;
  late bool isPdf;

  LecturesModel.fromJson(Map<String , dynamic> json){
    id = json['id'];
    name = json['name'];
    resource_type_id = json['resource_type_id'];
    course_id = json['course_id'];
    res = json['res'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    size = json['size'];
    isPdf = json['isPdf'];
  }
  // @override
  // String toString(){
  //   return 'name: $name , res : ${Uri.parse(res).toString()} \n';
  // }


}