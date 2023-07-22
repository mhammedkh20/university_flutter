class DistributionPointsModel {
  late int id ;
  late String? email;
  late String? name;
  late String? phone1 ;
  late String? phone2;
  late String? address;
  late String? created_at;
  late String? updated_at;

  @override
  String toString(){
    return 'id: $id , email: $email name: $name , phone1: $phone1 , phone2: $phone2 ,address: $address ';

  }
  DistributionPointsModel.fromJson(Map<String , dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone1 = json['phone1'];
    phone2 = json['phone2'];
    address = json['address'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }
}