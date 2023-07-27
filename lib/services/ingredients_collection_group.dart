import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/services/collection_group.dart';

class IngredientsCollectionGroup extends CollectionGroup<Ingredient> {
  static IngredientsCollectionGroup instance = IngredientsCollectionGroup();

  IngredientsCollectionGroup() : super(path: 'ingredients');

  @override
  Ingredient fromFirestore(snapshot, options) {
    return Ingredient.fromFirestore(snapshot, options);
  }

  @override
  Stream<List<Ingredient>> all({
    List<DocumentReference>? users,
  }) {
    return collectionGroup
        .where('user', whereIn: users)
        .orderBy('name')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
