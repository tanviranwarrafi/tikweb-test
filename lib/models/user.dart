class User {
  int id;
  String name;
  String email;
  String gender;
  String phone;
  String latitude;
  String longitude;
  String profileImage;
  String emailVerifiedAt;
  String password;
  String createdAt;
  String updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.gender,
    this.phone,
    this.latitude,
    this.longitude,
    this.profileImage,
    this.emailVerifiedAt,
    this.password,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    phone = json['phone'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    profileImage = json['profile_image'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['profile_image'] = this.profileImage;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['password'] = this.password;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
