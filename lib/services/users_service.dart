import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/services/service.dart';

class UsersService extends Service<User> {
  static final instance = UsersService();

  @override
  final CollectionReference<User> collection =
      FirebaseFirestore.instance.collection('users').withConverter<User>(
            fromFirestore: (snapshot, _) => User.fromSnapshot(snapshot),
            toFirestore: (user, _) => user.toMap(),
          );
}
