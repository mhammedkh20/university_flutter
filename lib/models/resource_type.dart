class ResourceType{
  late int id;
  late String name ;
  // late int resource_type_id;
  // late int course_id;
  // late String created_at;
  // late String updated_at;
  // late String res;
 

 ResourceType.fromJson(Map<String , dynamic> json){
   id = json['id'];
    name = json['name'];
    // resource_type_id = json['resource_type_id'];
    // course_id = json['course_id'];
    // created_at = json['created_at'];
    // updated_at = json['updated_at'];
    // res = json['res'];


   
   
    
   
}
}
