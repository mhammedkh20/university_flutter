class MajorModel{
   late int id ;
  late String name ;
  
  late int department_id;
  late String created_at;
  late String updated_at;

  MajorModel.fromJson(Map<String , dynamic> json){
    id = json['id'];
    name = json['name'];
   
    department_id = json['department_id'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
}
}