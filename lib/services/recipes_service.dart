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

  RecipesService() : super(path: 'recipes');

  @override
  Recipe fromFirestore(snapshot, options) {
    return Recipe.fromSnapshot(snapshot);
  }
}
