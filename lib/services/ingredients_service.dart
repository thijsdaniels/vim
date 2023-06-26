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

  IngredientsService() : super(path: 'ingredients');

  @override
  Ingredient fromFirestore(snapshot, options) {
    return Ingredient.fromSnapshot(snapshot);
  }
}
