class SemesterModel{
   late int id ;
  late String name ;
  
 
  // late String created_at;
  // late String updated_at;

 SemesterModel.fromJson(Map<String , dynamic> json){
    id = json['id'];
    name = json['name'];
   
   
    
   
}
}