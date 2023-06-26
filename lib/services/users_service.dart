import 'package:vim/models/user/user.dart';
import 'package:vim/services/service.dart';

class UsersService extends Service<User> {
  static final instance = UsersService();

  UsersService() : super(path: 'users');

  @override
  User fromFirestore(snapshot, options) {
    return User.fromSnapshot(snapshot);
  }
}
