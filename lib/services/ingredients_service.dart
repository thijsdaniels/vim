import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/services/service.dart';

/// TODO: Filter all operations by the currently authenticated user. It might be
/// a good idea to apply this generally to the entire service:
/// ```
///   instance
///     .collection('users')
///     .document(user.uid)
///     .collection('ingredients')
///     ...
/// ```
class IngredientsService extends Service<Ingredient> {
  static final instance = IngredientsService();

  @override
  final CollectionReference<Ingredient> collection = FirebaseFirestore.instance
      .collection('ingredients')
      .withConverter<Ingredient>(
        fromFirestore: (snapshot, _) => Ingredient.fromSnapshot(snapshot),
        toFirestore: (ingredient, _) => ingredient.toMap(),
      );
}
