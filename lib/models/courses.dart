
class CoursesModel{
   late int id ;
  late String name ;
  late int major_id;
  late int semester_id;
  late int year_id;
  late String created_at;
   late String updated_at;

  CoursesModel.fromJson(Map<String , dynamic> json){
    id = json['id'];
    name = json['name'];
    major_id = json['major_id'];
    semester_id = json['semester_id'];
    year_id = json['year_id'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
}
}