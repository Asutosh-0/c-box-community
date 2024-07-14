import 'package:firebase_auth/firebase_auth.dart';

class Auth_Services{
  final auth = FirebaseAuth.instance;
  Future<bool?> createUserWithEmailAndPassword(String email, String password) async {
    try{
      final create = await auth.createUserWithEmailAndPassword(email: email, password: password);
      var v = create.additionalUserInfo?.isNewUser;
      print("create user -= $v");
      return v;
    }catch(e){
      print("create : $e");
    }
    return null;

  }

  Future<User?> signinUserWithEmailAndPassword(String email, String password) async {
    try{
      final create = await auth.signInWithEmailAndPassword(email: email, password: password);
      print("Login = $create");
    return create.user;
    }catch(e){
      print("signin : $e");
    }
    return null;
  }
  
  Future<void> signout() async {
    await auth.signOut();
  }

}