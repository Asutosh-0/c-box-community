
import 'package:firebase_auth/firebase_auth.dart';

Future<String> SignUpUser(String email, String password) async
{
  try
      {
        UserCredential userCredential = await  FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

        if(userCredential!= null)
          {
            return "success";
          }
        else{
          return "error";
        }

      }
      on FirebaseAuthException catch (e)
  {
    return e.code.toString();

  }

}


Future<String> SignInUser(String email,String password) async
{
  try{

    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

    if(userCredential!= null)
      {
        return "success";
      }
    else{
      return "error";
    }
  }
  on FirebaseAuthException catch(er)
  {
    return er.code.toString();

  }

}