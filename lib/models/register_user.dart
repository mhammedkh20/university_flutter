class User{
  late var id ;
  late var email;
  late var payment_pic;
  late var password ; 
  late var phone;
  late var name;
  late var token;
  late var card_active;
  late var created_at;
  late var updated_at;

  User();
  User.fromJson(Map<String, dynamic> json){
    id= json['id'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    payment_pic = json['payment_pic'];
    name = json['name'];
    token = json['token'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    card_active =json['card_active'];
  }
}