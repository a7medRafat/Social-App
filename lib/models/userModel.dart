class UserModel{
  String? name;
  String? email;
  String? phone;
  String? uId;
  bool? isEmailVerified;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.isEmailVerified
});

  UserModel.FromJson(Map<String,dynamic>json){
    name = json['name'];
    email = json['email'];
    phone = json ['phone'];
    uId = json ['uId'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String,dynamic> ToMap(){
    return {
      'name':name,
      'email':email,
      'phone': phone,
      'isEmailVerified':isEmailVerified
    };
  }

}