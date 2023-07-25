import 'package:vim/models/food/recipe.dart';
import 'package:vim/services/collection_group.dart';

class RecipesCollectionGroup extends CollectionGroup<Recipe> {
  static RecipesCollectionGroup instance = RecipesCollectionGroup();

  RecipesCollectionGroup() : super(path: 'recipes');

  @override
  Recipe fromFirestore(snapshot, options) {
    return Recipe.fromFirestore(snapshot, options);
  }

  @override
  Stream<List<Recipe>> all() {
    return collectionGroup
        .orderBy('name')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
