class University { 
  late int id ;
  late String name ;
  late String photo;
  late String created_at;
  late String updated_at;

  University.fromJson(Map<String , dynamic> json){
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }
}