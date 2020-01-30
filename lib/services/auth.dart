import 'package:firebase_auth/firebase_auth.dart';
import 'package:vinter/models/data_models.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel _userModel(FirebaseUser user) {
    return user != null
        ? UserModel(
            uid: user.uid,
            name: user.displayName
          )
        : null;
  }
  Stream<UserModel> get user {
    return _auth.onAuthStateChanged.map(_userModel);
  }

  Future<String> updateUser(dynamic newUpdate, dynamic type) async{
    FirebaseUser user = await _auth.currentUser();
    UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
    if(type=='_username'){
      userUpdateInfo.displayName = newUpdate;
    }
    if(type=='_photo'){
      userUpdateInfo.photoUrl = newUpdate;
    }   
    await user.updateProfile(userUpdateInfo);
    user.reload();
    return userUpdateInfo.displayName;
  }

  Future userLogout() async {
    try {
      return _auth.signOut();
    } catch (ex) {
      print(ex.toString());
      return null;
    }
  }
}
