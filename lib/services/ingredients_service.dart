import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/ingredient.dart';

/// @todo Filter all operations by the currently authenticated user. It might be
/// a good idea to apply this generally to the entire service:
/// ```
///   instance
///     .collection('users')
///     .document(user.uid)
///     .collection('ingredients')
///     ...
/// ```
class IngredientsService {
  static final CollectionReference<Ingredient> _collection = FirebaseFirestore
      .instance
      .collection('ingredients')
      .withConverter<Ingredient>(
        fromFirestore: (snapshot, _) => Ingredient.fromSnapshot(snapshot),
        toFirestore: (ingredient, _) => ingredient.toMap(),
      );

  static Stream<Ingredients> all() {
    return _collection.snapshots().map((snapshot) =>
        Ingredients(snapshot.docs.map((doc) => doc.data()).toList()));
  }

  static Future<void> create(Ingredient ingredient) async {
    assert(ingredient.id == null);
    return _collection.doc().set(ingredient);
  }

  static Future<void> update(Ingredient ingredient) async {
    assert(ingredient.id != null);
    return _collection.doc(ingredient.id).set(ingredient);
  }

  static Future<void> delete(Ingredient ingredient) async {
    assert(ingredient.id != null);
    return _collection.doc(ingredient.id).delete();
  }
}

class Ingredients {
  final List<Ingredient> _ingredients;

  int get length => _ingredients.length;

  Ingredients(this._ingredients);

  Ingredient get(int index) {
    return _ingredients[index];
  }
}
