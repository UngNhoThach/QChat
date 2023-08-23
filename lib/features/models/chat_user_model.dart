class chatUserModel {
  late String? image;
  late String? uid;
  late String? about;
  late String? name;
  late bool? isOnline;
  late String? lastOnline;
  late String? createAt;
  late String? email;
  late String? phone;
  late String? pushToken;
  late String? age;
  late String? dateOfBirth;

  chatUserModel({
    required this.image,
    required this.uid,
    required this.about,
    required this.name,
    required this.isOnline,
    required this.lastOnline,
    required this.createAt,
    required this.email,
    required this.phone,
    required this.pushToken,
    required this.age,
    required this.dateOfBirth,
  });

  chatUserModel.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? '';
    uid = json['uid'] ?? '';
    about = json['about'] ?? '';
    name = json['name'] ?? '';
    isOnline = json['isOnline'] ?? false;
    lastOnline = json['lastOnline'] ?? ' ';
    createAt = json['createAt'] ?? '';
    email = json['email'] ?? '';
    phone = json['phone'] ?? '';
    pushToken = json['pushToken'] ?? '';
    age = json['age'] ?? '';
    dateOfBirth = json['dateOfBirth'] ?? '';
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['uid'] = this.uid;
    data['about'] = this.about;
    data['name'] = this.name;
    data['isOnline'] = this.isOnline;
    data['lastOnline'] = this.lastOnline;
    data['createAt'] = this.createAt;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['pushToken'] = this.pushToken;
    data['age'] = this.age;
    data['dateOfBirth'] = this.dateOfBirth;
    return data;
  }
}
