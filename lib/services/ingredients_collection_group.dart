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
  Stream<List<Ingredient>> all() {
    return collectionGroup
        .orderBy('name')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
