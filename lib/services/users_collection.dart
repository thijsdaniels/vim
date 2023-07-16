import 'package:vim/models/user/user.dart';
import 'package:vim/services/collection.dart';

class UsersCollection extends Collection<User> {
  static final instance = UsersCollection();

  UsersCollection() : super(path: 'users');

  @override
  User fromFirestore(snapshot, options) {
    return User.fromFirestore(snapshot, options);
  }
}
