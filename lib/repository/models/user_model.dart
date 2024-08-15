import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? name;
  String? email;
  int? createdAt;
  User? user;

  UserModel({this.name, this.email, this.createdAt, this.user});
  factory UserModel.fromUser(User user) {
    FirebaseAuth.instance.currentUser!.updateDisplayName('sherazi');
    FirebaseAuth.instance.currentUser!.reload();
    return UserModel(
      user: user,
      name: user.displayName,
      email: user.email,
      createdAt: user.metadata.creationTime!.millisecondsSinceEpoch,
    );
  }
}
