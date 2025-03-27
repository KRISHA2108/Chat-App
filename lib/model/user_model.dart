class UserModel {
  String uid;
  String name;
  String email;
  String password;
  String image;
  String token;
  int imageIndex;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.password,
    required this.image,
    required this.token,
    required this.imageIndex,
  });

  factory UserModel.fromMap({required Map<String, dynamic> data}) => UserModel(
        uid: data['uid'],
        name: data['name'],
        email: data['email'],
        password: data['password'],
        image: data['image'],
        token: data['token'],
        imageIndex: data['imageIndex'],
      );
  Map<String, dynamic> get toMap => {
        'uid': uid,
        'name': name,
        'email': email,
        'password': password,
        'image': image,
        'token': token,
        'imageIndex': imageIndex,
      };
}
