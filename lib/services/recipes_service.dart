import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/recipe.dart';
import 'package:vim/models/recipes.dart';

/// TODO: Filter all operations by the currently authenticated user. It might be
/// a good idea to apply this generally to the entire service:
/// ```
///   instance
///     .collection('users')
///     .document(user.uid)
///     .collection('recipes')
///     ...
/// ```
class RecipesService {
  static final CollectionReference<Recipe> _collection =
      FirebaseFirestore.instance.collection('recipes').withConverter<Recipe>(
            fromFirestore: (snapshot, _) => Recipe.fromSnapshot(snapshot),
            toFirestore: (recipe, _) => recipe.toMap(),
          );

  static Stream<Recipes> all() {
    return _collection.orderBy('name').snapshots().map(
        (snapshot) => Recipes(snapshot.docs.map((doc) => doc.data()).toList()));
  }

  static Future<void> create(Recipe recipe) async {
    assert(recipe.id == null);
    return _collection.doc().set(recipe);
  }

  static Future<void> update(Recipe recipe) async {
    assert(recipe.id != null);
    return _collection.doc(recipe.id).set(recipe);
  }

  static Future<void> delete(Recipe recipe) async {
    assert(recipe.id != null);
    return _collection.doc(recipe.id).delete();
  }
}
