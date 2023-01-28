import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/collection.dart';
import 'package:vim/models/ingredient.dart';
import 'package:vim/models/model.dart';
import 'package:vim/models/nutrition.dart';

class IngredientAmounts extends Collection<IngredientAmount> {
  final List<IngredientAmount> _ingredientAmounts;

  @override
  int get length => _ingredientAmounts.length;

  num get amount {
    return _ingredientAmounts
        .map((ingredientAmount) => ingredientAmount.amount)
        .reduce((total, amount) => total + amount);
  }

  Nutrition get nutrition {
    return _ingredientAmounts
        .map((ingredientAmount) => ingredientAmount.nutrition)
        .reduce((total, entry) => total.add(entry));
  }

  IngredientAmounts([this._ingredientAmounts = const []]);

  @override
  IngredientAmount get(int index) {
    return _ingredientAmounts[index];
  }

  @override
  List<Map<String, dynamic>> toMap() {
    return _ingredientAmounts
        .map((ingredientAmount) => ingredientAmount.toMap())
        .toList();
  }

  static IngredientAmounts fromMap(List<dynamic> map) {
    return IngredientAmounts(
      map.map((map) => IngredientAmount.fromMap(map)).toList(),
    );
  }

  Nutrition nutritionForAmount(num amount) {
    double factor = amount / this.amount;

    return _ingredientAmounts
        .map((ingredientAmount) => ingredientAmount.nutrition.multiply(factor))
        .reduce((total, nutrition) => total.add(nutrition));
  }

  @override
  Iterable<T> map<T>(T Function(IngredientAmount) toElement) {
    return _ingredientAmounts.map(toElement);
  }
}

class IngredientAmount extends Model {
  final Ingredient ingredient;
  final num amount;

  Nutrition get nutrition {
    return ingredient.nutritionForAmount(amount);
  }

  IngredientAmount({
    required this.ingredient,
    required this.amount,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'ingredient': ingredient.toMap(),
      'amount': amount,
    };
  }

  static IngredientAmount fromMap(Map<String, dynamic> map) {
    return IngredientAmount(
      ingredient: Ingredient.fromMap(map['ingredient']),
      amount: map['amount'],
    );
  }
}

class IngredientAmountsReference extends Collection<IngredientAmountReference> {
  final List<IngredientAmountReference> _ingredientAmounts;

  @override
  int get length => _ingredientAmounts.length;

  num get amount {
    return _ingredientAmounts
        .map((ingredientAmount) => ingredientAmount.amount)
        .reduce((total, amount) => total + amount);
  }

  Future<Nutrition> get nutrition async {
    return _ingredientAmounts
        .map((ingredientAmount) => ingredientAmount.nutrition)
        .reduce((total, entry) async => (await total).add(await entry));
  }

  IngredientAmountsReference([this._ingredientAmounts = const []]);

  @override
  IngredientAmountReference get(int index) {
    return _ingredientAmounts[index];
  }

  @override
  List<Map<String, dynamic>> toMap() {
    return _ingredientAmounts
        .map((ingredientAmount) => ingredientAmount.toMap())
        .toList();
  }

  static IngredientAmountsReference fromMap(List<dynamic> map) {
    return IngredientAmountsReference(
      map.map((map) => IngredientAmountReference.fromMap(map)).toList(),
    );
  }

  Future<Nutrition> nutritionForAmount(num amount) async {
    double factor = amount / this.amount;

    return _ingredientAmounts
        .map(
          (ingredientAmount) async =>
              (await ingredientAmount.nutrition).multiply(factor),
        )
        .reduce(
          (total, nutrition) async => (await total).add(await nutrition),
        );
  }

  Future<IngredientAmounts> resolve() async {
    List<IngredientAmount> ingredientAmounts = await Future.wait(
      _ingredientAmounts.map(
        (ingredientAmount) async => await ingredientAmount.resolve(),
      ),
    );

    return IngredientAmounts(ingredientAmounts);
  }

  @override
  Iterable<E> map<E>(E Function(IngredientAmountReference) toElement) {
    return _ingredientAmounts.map(toElement);
  }
}

class IngredientAmountReference extends Model {
  Ingredient? _ingredient;

  final DocumentReference ingredientReference;
  final num amount;

  Future<Ingredient> get ingredient async {
    _ingredient ??= (await ingredientReference
            .withConverter(
              fromFirestore: (snapshot, _) => Ingredient.fromSnapshot(snapshot),
              toFirestore: (ingredient, _) => ingredient.toMap(),
            )
            .get())
        .data();
    return _ingredient!;
  }

  Future<Nutrition> get nutrition async {
    return (await ingredient).nutritionForAmount(amount);
  }

  IngredientAmountReference({
    required this.ingredientReference,
    required this.amount,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      /// TODO: Find a way to store the `DocumentReference` as a `reference`
      /// type field. Right now I'm just storing it as a `string` field, but a
      /// `reference` field would be more correct.
      'ingredient': ingredientReference.path,
      'amount': amount,
    };
  }

  static IngredientAmountReference fromMap(Map<String, dynamic> map) {
    return IngredientAmountReference(
      ingredientReference: FirebaseFirestore.instance.doc(map['ingredient']),
      amount: map['amount'],
    );
  }

  Future<IngredientAmount> resolve() async {
    return IngredientAmount(
      ingredient: await ingredient,
      amount: amount,
    );
  }
}
