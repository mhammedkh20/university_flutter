class DepartmentModel{
   late int id ;
  late String name ;
  late String photo;
  late int university_id;
  late String created_at;
  late String updated_at;

  DepartmentModel.fromJson(Map<String , dynamic> json){
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    university_id = json['university_id'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
}
}