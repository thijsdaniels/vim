import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/food/recipe.dart';
import 'package:vim/services/service.dart';

/// TODO: Filter all operations by the currently authenticated user. It might be
/// a good idea to apply this generally to the entire service:
/// ```
///   instance
///     .collection('users')
///     .document(user.uid)
///     .collection('recipes')
///     ...
/// ```
class RecipesService extends Service<Recipe> {
  static final instance = RecipesService();

  @override
  final CollectionReference<Recipe> collection =
      FirebaseFirestore.instance.collection('recipes').withConverter<Recipe>(
            fromFirestore: (snapshot, _) => Recipe.fromSnapshot(snapshot),
            toFirestore: (recipe, _) => recipe.toMap(),
          );
}
