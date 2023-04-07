import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/food/amount.dart';
import 'package:vim/models/collection.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/models/model.dart';

class IngredientAmounts extends Collection<IngredientAmount> {
  num get amount {
    return entries
        .map((ingredientAmount) => ingredientAmount.amount)
        .reduce((total, amount) => total + amount);
  }

  Nutrition get nutrition {
    return entries
        .map((ingredientAmount) => ingredientAmount.nutrition)
        .reduce((total, entry) => total + entry);
  }

  IngredientAmounts([super.entries = const []]);

  static IngredientAmounts fromMap(Iterable<dynamic> map) {
    return IngredientAmounts(
      map.map((map) => IngredientAmount.fromMap(map)).toList(),
    );
  }

  Nutrition nutritionForAmount(num amount) {
    num factor = amount / this.amount;

    return entries
        .map((ingredientAmount) => ingredientAmount.nutrition * factor)
        .reduce((total, nutrition) => total + nutrition);
  }

  IngredientAmounts forAmount(num amount) {
    num factor = amount / this.amount;

    return IngredientAmounts(
        entries.map((ingredientAmount) => ingredientAmount * factor).toList());
  }
}

class IngredientAmount extends Model {
  final Ingredient ingredient;
  final num amount; // TODO: Turn into an instance of Amount.

  Nutrition get nutrition {
    return ingredient.nutritionForAmount(Amount.grams(amount));
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

  IngredientAmount operator *(num factor) {
    return IngredientAmount(ingredient: ingredient, amount: amount * factor);
  }
}

class IngredientAmountsReference
    extends MutableCollection<IngredientAmountReference> {
  IngredientAmountsReference([super.entries = const []]) {
    entries.sort((a, b) => a.amount > b.amount ? -1 : 1);
  }

  num get amount {
    if (entries.isEmpty) {
      return 0;
    } else {
      return entries
          .map((ingredientAmount) => ingredientAmount.amount)
          .reduce((total, amount) => total + amount);
    }
  }

  Future<Nutrition> get nutrition async {
    if (entries.isEmpty) {
      return Nutrition.zero;
    }

    return entries
        .map((ingredientAmount) => ingredientAmount.nutrition)
        .reduce((total, entry) async => await total + await entry);
  }

  static IngredientAmountsReference fromMap(Iterable<dynamic> map) {
    return IngredientAmountsReference(
      map.map((map) => IngredientAmountReference.fromMap(map)).toList(),
    );
  }

  Future<Nutrition> nutritionForAmount(num amount) async {
    num factor = amount / this.amount;

    return entries
        .map(
          (ingredientAmount) async => await ingredientAmount.nutrition * factor,
        )
        .reduce(
          (total, nutrition) async => await total + await nutrition,
        );
  }

  Future<IngredientAmounts> resolve() async {
    List<IngredientAmount> ingredientAmounts = await Future.wait(
      entries.map(
        (ingredientAmount) async => await ingredientAmount.resolve(),
      ),
    );

    return IngredientAmounts(ingredientAmounts);
  }
}

class IngredientAmountReference extends Model {
  Ingredient? _ingredient;

  final DocumentReference ingredientReference;
  final num amount;

  /// TODO: Turn this into a Stream<Ingredient?> for real-time updates.
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
    return (await ingredient).nutritionForAmount(Amount.grams(amount));
  }

  IngredientAmountReference({
    required this.ingredientReference,
    required this.amount,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'ingredient': ingredientReference,
      'amount': amount,
    };
  }

  static IngredientAmountReference fromMap(Map<String, dynamic> map) {
    return IngredientAmountReference(
      ingredientReference: map['ingredient'],
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
