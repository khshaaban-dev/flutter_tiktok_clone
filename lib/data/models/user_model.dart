class UserModel {
  final String name;
  final String email;
  final String imageUrl;
  final String uid;
  UserModel({
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
        'imageUrl': imageUrl,
        'uid': uid,
       
      };
       
  UserModel.empty()
      : name = '',
        email = '',
        imageUrl = '',
        uid = '';

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      name: json['name'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      uid: json['uid']);

  UserModel copyWith({
    String? name,
    String? email,
    String? imageUrl,
    String? uid,
  }) =>
      UserModel(
        name: name ?? this.name,
        email: email ?? this.email,
        imageUrl: imageUrl ?? this.imageUrl,
        uid: uid ?? this.uid,
      );
}
