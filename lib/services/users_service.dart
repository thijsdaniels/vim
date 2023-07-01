import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:vim/models/user/user.dart';
import 'package:vim/services/service.dart';

class UsersService extends Service<User> {
  static final instance = UsersService();

  UsersService() : super(path: 'users');

  @override
  User fromFirestore(snapshot, options) {
    return User.fromSnapshot(snapshot);
  }

  Future<void> createForFirebaseUser(firebase_auth.User authUser, User user) {
    assert(user.reference == null);
    return collection.doc(authUser.uid).set(user);
  }
}
