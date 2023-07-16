import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vim/models/document.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/routine_performance.dart';
import 'package:vim/models/food/ingredient_amount.dart';
import 'package:vim/services/exercises_collection.dart';
import 'package:vim/services/ingredients_collection.dart';
import 'package:vim/services/performances_collection.dart';
import 'package:vim/services/recipes_collection.dart';
import 'package:vim/services/routines_collection.dart';
import 'package:vim/widgets/molecules/with_confirmation_dialog.dart';

class DebugView extends StatelessWidget {
  const DebugView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug'),
      ),
      body: const Center(child: MigrateButton()),
    );
  }
}

class MigrateButton extends StatelessWidget {
  const MigrateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return WithConfirmationDialog(
      builder: (context, confirm) => FilledButton(
        onPressed: () async {
          if (!(await confirm())) {
            return;
          }

          // FirebaseFirestore.instance
          //     .collection('users/ZSBLclXCH8euEBERCPSNltS4Yvl2/consumptions')
          //     .where('recipe', isNull: false)
          //     .get()
          //     .then(
          //   (querySnapshot) async {
          //     for (var documentSnapshot in querySnapshot.docs) {
          //       print(documentSnapshot.reference.path);

          //       var ingredientConsumptionsCollection =
          //           documentSnapshot.reference.collection('consumptions');

          //       print('  deleting subConsumptions...');
          //       var oldConsumptions =
          //           await ingredientConsumptionsCollection.get();
          //       for (var documentSnapshot in oldConsumptions.docs) {
          //         await documentSnapshot.reference.delete();
          //       }

          //       var ingredientAmounts =
          //           documentSnapshot['recipe']['ingredientAmounts'];

          //       var amountUnit = documentSnapshot['amount']['unit'];
          //       var amountValue = documentSnapshot['amount']['value'];

          //       var amountFactor = amountUnit == 'servings'
          //           ? amountValue / documentSnapshot['recipe']['servings']
          //           : amountValue /
          //               ingredientAmounts.fold(
          //                 0,
          //                 (previousValue, ingredientAmount) =>
          //                     previousValue + ingredientAmount['amount'],
          //               );

          //       print('  creating subConsumptions...');
          //       for (var ingredientAmount in ingredientAmounts) {
          //         await ingredientConsumptionsCollection.add(
          //           IngredientConsumption(
          //             timestamp: documentSnapshot['timestamp'],
          //             ingredient: IngredientSnapshot(
          //                 Ingredient.fromMap(
          //                   ingredientAmount['ingredient'],
          //                 ),
          //                 reference: getIngredientReference(
          //                   ingredientAmount['ingredient'],
          //                 )),
          //             amount: Amount.grams(
          //               ingredientAmount['amount'] * amountFactor,
          //             ),
          //           ).toMap(),
          //         );
          //       }
          //     }
          //   },
          // );

          // await saveDocuments(
          //   ConsumptionsService.of(context)
          //       .collection
          //       .where('recipe', isNull: false),
          // );
        },
        child: const Text('Migrate'),
      ),
    );
  }

  Future<void> traverseSnapshots<D>(
    Query<D> query,
    Future<void> Function(
      QueryDocumentSnapshot<D> snapshot,
      int index,
      int length,
    ) visit,
  ) async {
    var snapshots = (await query.get()).docs;

    print('Found ${snapshots.length} snapshots.');

    for (var i = 0; i < snapshots.length; i++) {
      await visit(snapshots[i], i, snapshots.length);
    }
  }

  Future<void> traverseDocuments<D extends Document>(
    Query<D> query,
    Future<void> Function(D document, int index, int length) visit,
  ) async {
    await traverseSnapshots<D>(
      query,
      (snapshot, index, length) {
        return visit(snapshot.data(), index, length);
      },
    );
  }

  Future<void> saveDocuments<D extends Document>(Query<D> query) async {
    await traverseDocuments(
      query,
      (document, index, length) async {
        print(
          'Saving document "${document.reference!.path}" (${index + 1} of $length)...',
        );

        document.reference!.set(document);
      },
    );
  }

  /// TODO: Add proper support to move an ingredient from the public scope to
  /// the private scope and vice versa. The official implementation should not
  /// traverse through _all_ recipes (and consumptions), but specifically update
  /// only those documents that contain references to the moved ingredient.
  Future<void> moveIngredients(BuildContext context) async {
    var ingredients = IngredientsCollection(path: 'ingredients').collection;
    var myIngredients = IngredientsCollection.of(context).collection;
    var myRecipes = RecipesCollection.of(context).collection;

    print('copying ingredients...');
    await traverseDocuments(ingredients, (ingredient, index, length) async {
      print('  copying ingredient ${index + 1} of $length...');
      await myIngredients.doc(ingredient.reference!.id).set(ingredient);
      print('  done.');
    });
    print('done.');

    print('traversing myRecipes...');
    await traverseDocuments(
      myRecipes,
      (recipe, index, length) async {
        print('  updating recipe ${index + 1} of $length...');
        recipe.ingredientAmounts = recipe.ingredientAmounts
            .map(
              (ingredientAmount) => IngredientAmount(
                ingredientReference:
                    myIngredients.doc(ingredientAmount.ingredientReference.id),
                amount: ingredientAmount.amount,
              ),
            )
            .toList();

        myRecipes.doc(recipe.reference!.id).set(recipe);
        print('  done.');
      },
    );
    print('done.');
  }

  /// TODO: Add proper support to move an exercise from the public scope to
  /// the private scope and vice versa. The official implementation should not
  /// traverse through _all_ routines and performances, but specifically update
  /// only those documents that contain references to the moved exercise.
  Future<void> moveExercises(BuildContext context) async {
    var exercises = ExercisesCollection(path: 'exercises').collection;
    var myExercises = ExercisesCollection.of(context).collection;
    var myRoutines = RoutinesCollection.of(context).collection;
    var myPerformances = PerformancesCollection.of(context).collection;

    print('copying exercises...');
    await traverseDocuments(exercises, (exercise, index, length) async {
      print('  copying exercise ${index + 1} of $length...');
      await myExercises.doc(exercise.reference!.id).set(exercise);
      print('  done.');
    });
    print('done.');

    print('traversing myRoutines...');
    await traverseDocuments(
      myRoutines,
      (routine, index, length) async {
        print('  updating routine ${index + 1} of $length...');
        routine.exerciseReferences = routine.exerciseReferences
            .map(
              (exerciseReference) => myExercises.doc(exerciseReference.id),
            )
            .toList();

        myRoutines.doc(routine.reference!.id).set(routine);
        print('  done.');
      },
    );
    print('done.');

    print('traversing myPerformances...');
    await traverseDocuments(
      myPerformances,
      (performance, index, length) async {
        print(
            '  updating performance ${performance.reference!.id} (${index + 1} of $length)...');
        if (performance is ExercisePerformance) {
          print('    updating exercisePerformance...');
          performance.exercise = ExerciseSnapshot(
            performance.exercise.snapshot,
            reference: myExercises.doc(
              performance.exercise.reference.id,
            ),
          );

          myPerformances.doc(performance.reference!.id).set(performance);
          print('    done.');
        } else if (performance is RoutinePerformance) {
          print('    updating routinePerformance...');
          performance.routine.snapshot.exerciseReferences =
              performance.routine.snapshot.exerciseReferences
                  .map(
                    (exerciseReference) =>
                        myExercises.doc(exerciseReference.id),
                  )
                  .toList();

          myPerformances.doc(performance.reference!.id).set(performance);
          print('    done.');

          print('    traversing routinePerformancePerformances...');
          await traverseDocuments(
            performance.performancesCollection!.collection,
            (subPerformance, index, length) async {
              print(
                  '      updating exercisePerformance ${subPerformance.reference!.id} (${index + 1} of $length)...');
              (subPerformance as ExercisePerformance).exercise =
                  ExerciseSnapshot(
                (subPerformance).exercise.snapshot,
                reference: myExercises.doc(
                  (subPerformance).exercise.reference.id,
                ),
              );

              performance.performancesCollection!.collection
                  .doc(subPerformance.reference!.id)
                  .set(subPerformance);
              print('      done.');
            },
          );
          print('    done.');
        } else {
          print('    nothing to do...');
        }
        print('  done.');
      },
    );
    print('done.');
  }
}

DocumentReference getRecipeReference(Map<String, dynamic> map) {
  var idsByName = {
    "Café Americano": "34hH5QgzDVAj9Vbd34Pc",
    "Cappuccino": "kYoy4CnyCJ8Jm3b7UOJB",
    "Chicken Tikka Masala": "BKV9Ev75MKKDRmvYTb4D",
    "Chili con Carne": "qo4eLGFSvW4wryO58SS8",
    "Cortado": "IXV6Qa5yCZk8O4Km7MAE",
    "Hokkaido Milk Bread": "Skr3ejAb8LKjmDv0HsRo",
    "Honey Garlic Salmon": "8G270nCHTxdKT3715BVh",
    "Honey Mustard Sauce": "H5yuMC7yWmSS3iUyzsUm",
    "Hot Chocolate": "9qAanWSCl87Nfcq0tLps",
    "Macchiato": "KXDaIbQqKVExcDzMivS9",
    "Mocaccino": "lTQCES2JUM1GQFTxTefa",
    "Moscow Mule": "bYQ8lPM0lTbQNaMUQpKc",
    "Nigiri Avocado": "gFTZul5Hfn3cEeIE3kNu",
    "Nigiri Gyu-Niku": "hSO67amRC2bE80Rsg30X",
    "Nigiri Hotategai": "AVuBTq05DUvuTs3GHIYz",
    "Nigiri Kani": "VJBmbo5hDHWnoyOWIGXt",
    "Nigiri Maguro": "Fkj6Qa8vp5NfIMQzBVMF",
    "Nigiri Sake": "NEiWWrPB0FZn9zyhV9aq",
    "Nigiri Tamago": "z6AkuSdoABRooBZBSkLR",
    "Orange Chicken": "GydGuKVlx4Oiqiuhpldo",
    "Pre-Workout Shake": "Z2nEgKEJrhrIuhe6CwHY",
    "Protein Banana Bread": "o9ze8sGF0xavRHqa4u95",
    "Protein Pancakes": "ctV0Jno0WiWrSdfhIxHd",
    "Protein Shake Chocolate": "D2lTTFunc5JlQLT5FEBn",
    "Protein Shake Vanilla": "nIxMRi13NEo9UVLG1rD2",
    "Sushi Su's Tuna Poké Bowl": "JYsbNdQexH0mwhPIlUEd",
    "Tamagoyaki": "D6lonB0Grncrk5Ymfb0p",
    "Tony's NYC Bagels Omelette Supreme": "jF6ytuc35rlqbuc13i63",
    "Waffles": "iSRnC6m8Jlo09gIqbWfr",
    "Wheat Porridge": "bUMgYOWpVGbGWYpojGoy",
    "Zalm Timbaal": "4oJfz8fHj0GzVibvm9SC",
  };

  idsByName = {
    ...idsByName,
    "Sushi Su's Poke Bowl": idsByName["Sushi Su's Tuna Poké Bowl"]!,
    "Protein Waffles": idsByName["Waffles"]!,
    "Protein Shake Cookies & Cream": idsByName["Protein Shake Chocolate"]!,
  };

  var id = idsByName[map['name']];

  if (id == null) {
    throw Exception("Reference for recipe '${map['name']}' not found.");
  }

  return FirebaseFirestore.instance
      .doc('users/ZSBLclXCH8euEBERCPSNltS4Yvl2/recipes/$id');
}

DocumentReference getIngredientReference(Map<String, dynamic> map) {
  var idsByName = {
    "Tomato Puree (Albert Heijn)": "019r4qzDWtMnXn23UJDh",
    "Apple Elstar (Albert Heijn)": "0EjpVLXPEcMS0HTTeA1r",
    "Spitskool (Albert Heijn)": "0Gcz9ZTxKPVTde6VgHmh",
    "Peanuts Dry-Roasted (Albert Heijn)": "0OdOkBCsz5BtidAdLlKD",
    "Garlic (Albert Heijn)": "0Rcjg4aaA7vKBhS5tHIW",
    "Tea-Stained Egg (Wagamama)": "0XZHLA73FvaNNArCeVba",
    "Rucola Slamelange (Albert Heijn)": "0as88HXtzzy5DfIwbPrO",
    "Lentil Chips (Upfront)": "0d9yMw3rrWDQfxWEUN3n",
    "Skyr Strawberry & White Chocolate (Ísey Skyr)": "0pJhplz58nVH9DLTuqDO",
    "Doritos Nacho Cheese (Doritos)": "11Xz2b7vIvqx19U2Hm2W",
    "Beschuit (Bolletje)": "1K7Q09uVq4rv0JtIcM1O",
    "Skyr Aardbei (Arla)": "1NDYQdvH6g8lCUiLUkC4",
    "Cayenne Pepper, Fresh (null)": "1PYiX87c5olvdVGnZYCo",
    "Kiwi Sungold (Zespri)": "1lqlrskJA2z79r7gyIWM",
    "Bombay Curry (Fuel Your Body)": "1nQbHOCVSlhRR8alyYpe",
    "Cherry Tomatoes (Albert Heijn)": "1vOv0FyeLgAueKDDUjtB",
    "Pannenkoek Naturel (Albert Heijn)": "200PM7EeTXQei2ywImYr",
    "Stokbrood Wit (Albert Heijn)": "2KFuNKLE8cvbBM2m2yXR",
    "Krentenbol Volkoren (Albert Heijn)": "2O35NkjP9wxnyYInGxIZ",
    "Saucijzenbroodje (Albert Heijn)": "2a1ytmVgpfNg0AoxphIw",
    "Skyr Vanille (Arla)": "2eibgmYYKOi12w5ZqtDp",
    "White Asparagus (Albert Heijn)": "2gTKNhgXtxfZdXb4RO10",
    "Prei Kerrie Soep (Albert Heijn)": "2kUsNob8iHvGxYyT99j5",
    "Geroockte Speckjes (De Vegetarische Slager)": "2mVTZLuZrUPaAFHqvRKy",
    "Bapao Beef (Humapro)": "2nsB4vuWAB4DVbQfK2Cw",
    "Inca Berries, Dried (De Notenshop)": "2qsPXaJ9KO62PTNBWeuB",
    "Basmati Rice (Albert Heijn)": "2rpHJUQrDVPMW2swAzne",
    "Unsalted Butter (De Zaanse Hoeve)": "2zG9XpskSTBdji5Mpw9Z",
    "Ossenhaas (Albert Heijn)": "3S2Eo622ws3jWJ4Vspda",
    "Single Big Tasty (McDonald's)": "3T649CTYRXeA8DBRzsND",
    "Potato Nicola (Albert Heijn)": "3be7Bh5kPjeYrm8387Pw",
    "Grilled Chicken Ramen (Wagamama)": "3oDxlBaYFZNR00rolLcV",
    "Smoked Sockeye Salmon (Fish Tales)": "3u0HoOIVUYvuy2SZmsp9",
    "Chili sin Carne (Lazy Vegan)": "3vGny72NciSBxcoSlWaZ",
    "Ice Tea Peach Zero (Lipton)": "43MN30C64Jaoc4ChKhjn",
    "Edamame (null)": "47ujV9ndVoRA9HlCMDCX",
    "Red Kidney Beans (Bonduelle)": "4LMJ89A8Cg8jciQiBd5d",
    "Casarecce (Hello Fresh)": "4pj6SXrWL6cv6Q4X8WYe",
    "Kip Teriyaki, Rijst & Sugar Snaps (Muscle Meals)": "551Bes5aguQyECCfovU4",
    "Fresh Foodie Spaghetti & Meatballs (Gorillas)": "5DdKaGQxBXoGAKBaz0Bk",
    "Whey Protein Pro Vanilla (MB Nutrition)": "5YUBzkWsePWyRK46pjHM",
    "Snack a Jacks Cheese (Snack a Jacks)": "5qWy1PtyKJ1m8lT1jOdP",
    "Tomato Soup (Oma's Soep)": "5qzoOZw9tbIdK5Vmv9K7",
    "Sweet Potato, BBQ Pulled Chicken & Roasted Corn Mix (Fuel Your Body)":
        "64eC4uD5CadibsqRU0Fm",
    "Mac & Cheese, Unprepared (Kraft)": "653mTM2iTHSxWawIYKPg",
    "Pasta Bolognese Bulk (Prep the Food)": "6R39fRGOrrM11aTNFIo9",
    "Vanilla Extract (De Notenshop)": "6WVJ1Br10kTyNHxTBpwm",
    "Margarine (Albert Heijn)": "6bkzZZcnnkH0BVJwuiYt",
    "Oven Baked Naturel (Lay's)": "6rpYD7C4ZvFhnlEHcK2x",
    "Strawberry Jam (Bonne Maman)": "79qjGTt0OuOdk53z7pgQ",
    "Zalm Teriyaki Rijst Groente Bulk (Prep the Food)": "7WPa1yb6rGjPE4H6x4C3",
    "Skyr Blueberry Pie (Ísey Skyr)": "7ZTL1PW9qxVeFCQE1y0I",
    "Sushi Rice (Albert Heijn)": "7fFiZp2R7MhYULFzkAxM",
    "Festini Pear (Ola)": "7fI2Dov7ENjvgngFPa2q",
    "Miso Paste (Saitaku)": "7g2hprPZBtb1470X5XjD",
    "Pesto alla Genovese (Grand'Italia)": "82p8O2E2L6tlCVzuUAr7",
    "Bitterballen Pizza Margharita (Dr. Oetker)": "84ArzhGqh1Ar2IsSYNws",
    "Bacon (Albert Heijn)": "8F0HgZpldYB03Z8ZiHst",
    "Prosciutto di Parma (Albert Heijn)": "8g8JFmnMr5ixiIvgfLb5",
    "Knäckebröd Volkoren Rogge (Wasa)": "8j54Djy3ydEgx2bv6noW",
    "Ginger (Albert Heijn)": "8oVcY3MQ62L2JfIlynFn",
    "Hollandaise Saus (Hello Fresh)": "8oqrMNsRQTLxg780Se85",
    "Knaks (Unox)": "8q2AHtJtCASGIhVPwE0J",
    "Cocoa (Blooker)": "92k5WFVrhR1NG37Q9yvC",
    "Venom Pre-Workout Drink (XXL Nutrition)": "9HpcNIonF0q4ZibQWwAF",
    "Peas (Bonduelle)": "9J9i01SS5juxqTuYXYmP",
    "Cucumber (null)": "9NI60lEqVvQIEs1oCLgt",
    "Whey Protein Vanilla (Decathlon)": "9S4DYDgfsFd4yjeyOU2C",
    "Sweet Royella Bramen (Albert Heijn)": "9e9NFRQOfAo1Gr5v5cq4",
    "Kookpakket Beef Teriyaki (Albert Heijn)": "9jWYYjpjwXpevkKtIpW1",
    "Duitse Biefstuk (Albert Heijn)": "9tjWq16Uyy2P6edrrT1m",
    "Campagnard (Albert Heijn)": "A075iABXiYNCfjbusrY0",
    "Blueberries (null)": "AFtl10GMS7XFpTG7Y6Aj",
    "Cream Cheese with Herbs (Hello Fresh)": "AQj1keARivxtWJPcPO3c",
    "Kip Piri Piri, Rijst & Wokmix (Muscle Meals)": "AyIZnvMawlb8rYR7w4ii",
    "Tomato Rice, Chicken, Red Onion & Feta (Fuel Your Body)":
        "B0jffbKvqBiF6kcFDi1w",
    "Kaiserbroodje Volkoren (Jumbo)": "BED80yoC1Dq1BlMgybr3",
    "Portobello (Albert Heijn)": "BFwTYHAf77Z5OJjLbLvy",
    "Green Asparagus (null)": "BIRubXrUVhINeSMZpHKh",
    "White Chip Macademia Nut Cookie (Subway)": "BXZGkNNAU81YsuhKkOuq",
    "Tomato (Albert Heijn)": "Bad8jdmbVjNH1MIwrhI5",
    "Salmon (null)": "Bg1b5H2ndnm7EFQZA78R",
    "Crispy Chicken Strips (Kentucky Fried Chicken)": "C0mKmF4v8fDKiKReHiuj",
    "Fuet Extra (Caula)": "C2pDpFhCDOX23xCbjXwB",
    "Pesto Rosso (Albert Heijn)": "CCOklvfO1SeFVI1oQzn8",
    "Apple Pie (Albert Heijn)": "CFJpi0BAZTgmbawUPJ9j",
    "Bagel (Albert Heijn)": "CJyuxlLx8ZhKFliwYSx5",
    "Broccoli (Albert Heijn)": "CipXO07M1eb7wIz6slEP",
    "Krentenbol (Albert Heijn)": "Cjk9eWuoC8q39bxEG420",
    "Yellow Rice, Chicken & Red Cabbage with Apple (Fuel Your Body)":
        "Cnhm4MJhFKqBRtzZElpo",
    "Pork Loin (Albert Heijn)": "CrdstEP3HUc7w4gDnmIB",
    "Red Onion (Albert Heijn)": "DDqMNA8yTYEoaFnVMcuB",
    "Sesame Oil (Kadoya)": "DZI0uyFLEB2O9CZQyxI4",
    "Kip Kerrie, Rijst & Mexico Mix (Muscle Meals)": "Dcv1YvJB64XxJWCmeUlY",
    "Snoepgroente Tomaat (Albert Heijn)": "DsDZwlYi2quVcKUY4pYf",
    "Serranoham (Albert Heijn)": "DwdpwSGn7GDhGJqdAMTE",
    "Soy Milk Plant Protein Chocolate (Alpro)": "E42Dwib61JbNrlbkYagA",
    "Ginger Beer (Royal Club)": "E8o5WGzqNYyeNzNKRtPc",
    "Water (null)": "EGxgfV6QWl2p3nXx6jMq",
    "Aioli (Albert Heijn)": "EcLe8lFawXu4hl7PxLT5",
    "Gegrilde Groenten (Albert Heijn)": "EerbBykRPKqXCzbjVA0z",
    "Soy Milk No Sugar (Alpro)": "EvgpDXPAyKm9aRR9dQMZ",
    "Soy Milk Plant Protein (Alpro)": "FCdVPMqxHU1VT6wJZrZ6",
    "Chicken Gyoza (Wagamama)": "FNSnqpbplqexrj35qkfu",
    "HiPRO Skyr Vanille (Danone)": "FSPbm25vczZijhVWlyih",
    "Leek (Albert Heijn)": "G0WKRUOaiZx5PKpRDPjC",
    "Wholewheat Sourdough Roll (Albert Heijn)": "GHuigAPtbhwgzNcquVtp",
    "Hummus Grilled Paprika (Jumbo)": "GJNzgrDT1G5Uc9Zzx8sR",
    "Spring Onion (null)": "GjLaHTs7OgIUHhUSByBf",
    "Cashew Nuts Salted (Albert Heijn)": "GmLe1tqiLN5UhwQu86JR",
    "Mayonnaise (Calvé)": "H0rUK8FcvPWWKGA2W7lQ",
    "Hummus (Albert Heijn)": "HE8XndOMbxhHWXyjhSpD",
    "Protein Bar Cookies & Cream (Quest)": "HNQqVmud4TnjMT5v5afD",
    "Orange Juice (Albert Heijn)": "HOT7hoU945yHhfV4sE1T",
    "Apricot Jam (Bonne Maman)": "HkxQpnEmzxmz1MwPJZSH",
    "Chili Pepper (null)": "ISuiwrnm5x0dRK3RPDQa",
    "Whey Isolate Banana (XXL Nutrition)": "ITRIENyxF7oDvTFoorX3",
    "Duchess Potatoes (Aviko)": "Ij0zcXsbvXN1fo5oVQtp",
    "Pizza Stromboli (Crosta & Mollica)": "J08z0SD6IxHE86k06PtE",
    "Bitterballen Gefrituurd (null)": "JfdO0gjZrYL7rSn56XBj",
    "Tortilla (Hello Fresh)": "JrMscdVsr9DA76wtprzl",
    "Desem Bruin Meerzaden (Albert Heijn)": "JrYXL9nIDqpWJ0ihFUnk",
    "Skyr Crème Brûlée (Ísey Skyr)": "K07QfaRwQKGJ3QMe6C9S",
    "Ice Tea Green Zero (Lipton)": "K7TEbqneIeEYAXs6O7Cx",
    "Whole Wheat Penne, Piri Piri Chicken & Mexico Mix (Fuel Your Body)":
        "K9SwAKwhk8q9psMSUb9K",
    "Creatine Monohydrate (XXL Nutrition)": "KIZAkjx0V3kvXEBB00Rx",
    "White Wine Vinegar (Albert Heijn)": "KPJX3yWSKwJi3qjcKjPR",
    "Carrots (Albert Heijn)": "KUu3IoNb7k1y3nQjBYJL",
    "Rice Vinegar (Saitaku)": "KlBlTehOqW2cpvUZcmsH",
    "Hagelslag Puur (De Ruijter)": "LIinKpVDpV8Z3m0CM88g",
    "White Wine (null)": "LdSiRK3U2BZzHapWhu3w",
    "Broccoli, Frozen (Alvert Heijn)": "LfCqVDPMsbwULBmNDxFH",
    "Light Sauce Mayo Zero (XXL Nutrition)": "LspvsBT0UVp9BpUlzlL7",
    "Chili Powder (null)": "LxhI8WFt7qtty9XevAPE",
    "Skyr Naturel (Arla)": "MAObMCDY5LA0zT7mSS3g",
    "Crunchy Muesli Chocolate (Holie)": "MCbyYUbT8ez9vZb533kg",
    "Chocomel Halfvol (Friesland Campina)": "MDEH9lDat6Dq5ORA7PIs",
    "Kip Classic, Rijst & Groentemix (Muscle Meals)": "MDaZC7kU8UpYxzq0cumr",
    "Tea (null)": "MLlC6i09AXtG70lGZFjD",
    "Smoked Salmon (Lerøy)": "MnvOwSie5xXrEaAA3eCq",
    "Hummus Pompoen (Albert Heijn)": "Mry2VGOa6YMMMoTb6UNW",
    "Mango Eetrijp (Albert Heijn)": "N3hPKRbSaOJDJzN44Rw3",
    "Roe (null)": "NNLVlCSUF6v8iIWRJpDY",
    "Kip Surinaamse Rijst Groente Bulk (Prep the Food)": "NU6kTGzJHGMLZNXH3opS",
    "Filet-O-Fish (McDonald's)": "NtrZtM7LQjPxwcNYZ0E9",
    "Spinach (null)": "OEmGOZ2zivFlnL0Fj1So",
    "Vodka (null)": "ORV7GaFqIWsi3VoQderq",
    "Vega Kip Eiernoedels Groente (Prep the Food)": "OpAnalHDfY22FWpG7b41",
    "Kip Kerrie, Rijst & Sperziebonen (Muscle Meals)": "OqrnF4JSxftLLsbjvmpR",
    "Burrito Smokey Beef (No Fairytales)": "OteuTrIOM8Xd2AnzMb3L",
    "Cumin (null)": "P0BU3ReOERP7h7bRobl0",
    "Blondies Mini (De Bijenkorf)": "PEXPabdxl2UQeYwDX9Go",
    "Cottage Cheese (Domspitz Milch)": "PIW0uj9DSpTIfnKd9uTM",
    "HiPRO Kwark Banaan (Danone)": "Pb7UGKTxizd8iwzz4L2i",
    "Milka Caramel (Milka)": "Q8AR7HK8KUysrLwFNjq7",
    "Bao Korean BBQ Beef (Wagamama)": "QAmSkKCMoYrrdT7FKKYt",
    "Smeltkaas met Cheddar (Albert Heijn)": "QFhOnTCjy8y9SjoZ5RyU",
    "Sweet Potato, Chicken Burger & Red Cabbage with Apple (Fuel Your Body)":
        "QPnpU3b9m2Mj1XZomD50",
    "Sweet Potato Fries, Chicken Burger & Mexico Mix (Fuel Your Body)":
        "Qm50F461033R5UcyO7Rj",
    "Kipfilet Blokjes (Albert Heijn)": "QswFWda5552xO8j8B2tz",
    "Chocolate-Banana Shake (Nom Nom Nom)": "QvAUFS9gCgEokujF2zSx",
    "Parmigiano Reggiano (Albert Heijn)": "RMZ3ae7Js2KBLaaS2pjr",
    "Sweet Potato Pillows (Nom Nom Nom)": "RhqFWowUk7Ztr8Lv68qI",
    "Wheat Flour (Albert Heijn)": "RiryBMuiTMu31HxrLvtp",
    "Kiwi Green (Zespri)": "Rp0TKAt1IMSjKuyhZeHn",
    "Chicken Filet Strips (Jumbo)": "Rq6nTUWR3iPU15sqEjzq",
    "Knäckebröd Volkoren (Wasa)": "SAvzcNBZr7ABMthWmlwZ",
    "Romaatjes (Albert Heijn)": "STnOwzzrHCJaFwZpJdVc",
    "Guacamole (Albert Heijn)": "SdPrhheJnaTGrvbnztQt",
    "Onion (Hello Fresh)": "Seov7PFgLtOD7t0IUK2Y",
    "Kipfilet Sweet Chili (Albert Heijn)": "Sr0Br4RLz2rGTA7v56Cw",
    "Gebraden Kiprollade (Hesseling)": "TG2H3FST2JZsPiHm4u1g",
    "Mirin (Saitaku)": "TJMOCHhCbv87tkLdHDGv",
    "Pesto Chicken Wrap (Kiosk)": "TM2WZsa602v9bpasBQSx",
    "Cruesli Apple, Pecan & Cinnamon No Sugar (Quaker)": "TN6S6R8V8tTnWlB1Ep6f",
    "Greek Yoghurt (Weerribben Zuivel)": "TU1derNvxkApFUO9GEJ8",
    "Krokante Rösti Rondjes (Albert Heijn)": "TXAGnStRpnjuzBWskKAY",
    "Orange (null)": "TaMaYesBjju7vkO0iSMm",
    "Sourdough Roll (Jumbo)": "TcVKWLfFrD8FlltzDMa4",
    "McChicken (McDonald's)": "TmM1Edq0ZZxXiAP4RelE",
    "Zucchini (null)": "TslnEnqF8Us7PCFlCYPG",
    "Gehakt Eiernoedels Groente Bulk (Prep the Food)": "TxSnQJBvgg9IyWdkJdpS",
    "Chopped Tomatoes (Albert Heijn)": "UEvlNji9R2Hcnju2Ya9v",
    "Udon Noodles (Hello Fresh)": "UIyhECTTfPmCdsEvrEs7",
    "Gouda Aged 48+ (Hello Fresh)": "UPWexBWgw9M6xWxUsMzB",
    "Mayonnaise Wasabi (Kewpie)": "UQk6IRbmfOSQgESOiGPU",
    "Flinterdunne Rauwe Achterham (Albert Heijn)": "UYcCaozSAkk7rh2NrnKH",
    "Lentil Chips Barbecue (Proper Chips)": "UtviD7Vptkh3KEjV06lP",
    "Almond Milk No Sugars (Alpro)": "VIzkcW74a2BiEYRpcQit",
    "Apricots, Dried (Albert Heijn)": "VXgFdWl43cb1tYgjrqe7",
    "Krentenbol (Bakkers Brigade)": "Vaqa2ddrZOsuBI6LLrKa",
    "Salmon Fillet (Lerøy)": "VmLNSacERmIGLPYKpuER",
    "Premium Pilsener (Warsteiner)": "W9VYFaYDx0iVoMfiVXxF",
    "Mango (Fuel Your Body)": "WCEZeilvM1y6eCUFRKFn",
    "Tortilla Carrot (No Fairytales)": "WQXgFiuhW7LHuttUSnRl",
    "Green Beans (Bio+)": "WYJDJlFrsNBfGHxxtE7S",
    "Sweet Chili Sauce (Go-Tan)": "X5Stle8ImnjpaTBsZAew",
    "Pasta Roomsaus Kip Bulk (Prep the Food)": "XkrieUpcAtObidArsGgk",
    "Ossenworst (Albert Heijn)": "XmKvF4jJdHc5LxnleoJM",
    "Mayonnaise (Hellman's)": "XqF3SucVWQlBdVB9ZUKR",
    "Beef Stock Cubes (Albert Heijn)": "XsDY1kOlw04R4QIZtRSB",
    "Achterham (Albert Heijn)": "XtbVzXXUb34aTW7X2fJv",
    "American Cheese (null)": "Xu31UM7RK41cVxpQ5ZDE",
    "Croissants (Albert Heijn)": "XuubSZmtY0s5GR1ZJb1S",
    "Rice Crackers (Albert Heijn)": "Xv4zbKBwKyGozSWXni8w",
    "Egg (Albert Heijn)": "Y33dPmZrlDF0SXs3x0oU",
    "Goat's Cheese Aged 30+ (Albert Heijn)": "YIdF8eWnlO3UXM3r4odI",
    "Pandan Rice (Albert Heijn)": "YfQGAupaJJJAIxhd0BoG",
    "Tortilla Tomato (No Fairytales)": "YhYpeit8cZlqFhU0kRKy",
    "Whey Isolate Raspberry (XXL Nutrition)": "YuU7yjPPYYDo7dowHfmZ",
    "Baking Powder (Albert Heijn)": "YvtBRDnldxFyns6IoJNF",
    "Flinterdunne Achterham (Albert Heijn)": "Z19zjgJcc3EkAEtsG1NT",
    "Choco Popcorn (HEMA)": "ZlyarINkhSSTEQu9VKXv",
    "Kipfilet Tuinkruiden (Albert Heijn)": "ZmrzlO9AwFHZuhZQ5JAU",
    "Wilde Zalm Filet (Albert Heijn)": "ZrstED2xysuhWq9rdypn",
    "Lemon Juice (Albert Heijn)": "a8WlnXXXgVcs7XmPeFFk",
    "Homestyle Crispy Chicken Greek (McDonald's)": "aKrLcsno1qW58yI4bs2O",
    "Sweet Potato Mash, Minced Chicken Rolls & Red Cabbage with Apple (Fuel Your Body)":
        "aN9vnCPgRBEaNNo5NrF6",
    "Honey Light Mix (Melvita)": "agoPlspoEYCJKbMbPoZZ",
    "Casein Protein Vanilla (Decathlon)": "av8RbOkMz3A2jUqoN7l3",
    "Lime Juice (null)": "b0r0DEhreMDwEQn1Hyr4",
    "Ricotta (Galbani)": "bCICninmZU6R7nGl9e0n",
    "Dill, Dried (null)": "bHqWGz8mdXTmPWElpCN0",
    "Zaanse Mosterd (Mosterdmolen De Huisman)": "bKnLCthNJhDAsc1pdu9S",
    "Cod Fillet (Fish Tales)": "bWjLxOVGuvMGKLstX9GE",
    "Granola (Hello Fresh)": "bc5xwsKxdEp0I4aifVTj",
    "Kokosmakronen (Albert Heijn)": "biyiYDMwuUNKLyvRvC6j",
    "Protein Yoghurt Mango (Melkunie)": "bvKlVw6zXk04T5On0FYy",
    "Gerookte Kipfilet (Smakelijk Vers)": "c4Ly8Nu6ySAA6yWj6LjH",
    "Protein Bar Vanilla Chocolate (XXL Nutrition)": "ceX9lqNHIaOYYNEeQqGx",
    "Hummus Gegrilde Groenten (Albert Heijn)": "cs7nSSBbjG5vvhHPXLsI",
    "Raspberries (null)": "dAjgiUlAz80t1qEtP4pF",
    "McKroket (McDonald's)": "dL6vUsLSyND1zdBa2GhR",
    "HiPRO Protein Drink Vanilla Cookie (Danone)": "dfLg9NGTOKH2HNikXnW8",
    "Tonijn Steak (Albert Heijn)": "djsTCuYOc0gdcUCv2SOR",
    "Muisjes (De Ruijter)": "dlPNvaT2QAt6APbToQJx",
    "Salmon Filet (Albert Heijn)": "eblyKUiNks35fTBUg9o4",
    "Avocado (null)": "eibiOx4Ox0Zjz3xEuY1a",
    "Soy Milk Packed with Protein (Alpro)": "ekI7ZGKVUvV21CO85zIv",
    "Banana (null)": "eqoZooCRu5EDi3wmGa8m",
    "Tesnef White (IKRA Bakeries)": "f1SXoe3L0CssGQX5ZIaG",
    "Fruitijs Tropical (Albert Heijn)": "f4WYrOJvcXABlIZ2rAba",
    "Gnocchi № 46 (De Cecco)": "f5NwFHg0FKkhhDPlMO3Z",
    "Surimi (Albert Heijn)": "fRCUTo4NJtjt1UbgHp8w",
    "Blast! Cherry (XXL Nutrition)": "fUtr40PLuan6UPxTvJgJ",
    "Bell Pepper Red (Hello Fresh)": "g5Uq1xgBoniGzvVf8Cbl",
    "Moon Crackers (Albert Heijn)": "g5ynMUmZtxoHO3zDHuQZ",
    "Yorkham (Albert Heijn)": "gIx4Y3Z1roF2kRVwSiBZ",
    "Blast! Fruit Punch (XXL Nutrition)": "gVeLOEXKwt5q4U1JSSfJ",
    "Bimi Broccoli (Bimi)": "gVrgBicAfeOOf9ukbwhZ",
    "Tuna (null)": "gbqi7OGQpwSptxTiSpmC",
    "Chicken Thigh Filet (Albert Heijn)": "geWRvVmzYlIbTJN4lj0b",
    "Vruchtenstol met Amandelspijs (Albert Heijn)": "ggEBSk6nqBfc7alYFCjw",
    "Brownies Mini (De Bijenkorf)": "gsYRGnog4R8RHIN3X2WI",
    "Oven Baked Paprika (Lay's)": "gwIy2ZNINepA6nbQiLQN",
    "Ketchup (Heinz)": "gzDsJM0Emg4SFWmwgVbb",
    "Pizza Imperia (Crosta & Mollica)": "h93TyWZuzz3w0PhC76bq",
    "Scharrel Kipfilet (Albert Heijn)": "h9adlosvyC8tepektpBY",
    "Gerookte Kippenham (Hesseling)": "h9zq5Hs22PbF3CoNZKAS",
    "Pink Shrimp (Hoogland Vis)": "hKKmZMWAbWux1Tf5wQwT",
    "Wheat Gluten (De Notenshop)": "hS2kI2WdYdoFFjZXKQLP",
    "Sugar (null)": "hbIcNrQCAPvpZhNwOWW6",
    "Whey Protein Cookies & Cream (Decathlon)": "hk9urpheR2my5Luj3SQt",
    "Light Sauce Sweet & Sour (XXL Nutrtion)": "hnMN27EwpoAvc2PJkJNU",
    "Olive Oil (Albert Heijn)": "hpEPwofyuzWZETrImI6l",
    "Honey (Jumbo)": "hz2kvUIfifaCvUnWzjXn",
    "Chicken Fajita Sub 6\" (Subway)": "iJ5cKSb6WrgbitIaSNm0",
    "Rode Puntpaprika (Albert Heijn)": "ifkKLBDAdk8tgyGJKPCC",
    "Sugar Snaps (Albert Heijn)": "ihtqdB86oPNOhweXbA2j",
    "Coca Cola (Coca Cola)": "ixi395cT366mZCfrgzHP",
    "Broccoli, Frozen (Gwoon)": "j5G3HgKzmTGQwnknJqW5",
    "Ice Cubes (null)": "jLtBJQZUit84x0TjTkzC",
    "Chips Naturel (Lay's)": "jOk80AHrssPNiH28vz9U",
    "French Fries Medium (McDonald's)": "jOmZ5zyqabQwdsIcgl2R",
    "Scallop (null)": "jbRWOY8YDdUY7VH5lRTM",
    "Snack a Jacks Barbecue Paprika (Snack a Jacks)": "jwUzjLsSPvrRXay4jubq",
    "Chicken Stock Cubes (Albert Heijn)": "k01RM6R3NrEbaLHFHvOE",
    "Panini's (Albert Heijn)": "k1eSFSe4mm5p4OTdkpw5",
    "Smoked Salmon (Jumbo)": "kBdaRU7greovGcw8X61y",
    "Limonadesiroop Aardbei (Albert Heijn)": "kJq9yLvdQ9Tu4CrdEL1o",
    "Protein Bar Berry Yoghurt (XXL Nutrition)": "kRQ5LcOMZphmCaqf2OUd",
    "French Fries, Frozen (Aviko)": "kRy8rFaGF81s0qVMoB2X",
    "Whey Isolate Vanilla (XXL Nutrition)": "kfJE5aCUPWX2oFHgDZsy",
    "Tijgerbrood Wit (Albert Heijn)": "kgAL0o0MSsouK0rxErTa",
    "Kidney Beans (Hello Fresh)": "kkycSca8ZZsCxRABmQ2f",
    "Granola Chocolate Crunch (Holie)": "kmuJB9tTtOKhsnCRJoJm",
    "Brioche Bol (Hello Fresh)": "kn4lNoRSxt3elY4xtVmB",
    "Soy Sauce (Albert Heijn)": "lKeBwEBi2BdHkuGW0mbq",
    "Cracotte Volkoren (LiGA)": "lM58Gjy5D28xCFXTOKLc",
    "Raisins (Gwoon)": "lN7Fp4P55GFsmbWyJuOs",
    "White Rum (Bacardi)": "lPgZkwceAmEJnz0cBZ4p",
    "Salmon Filet, Frozen (Albert Heijn)": "lcuzxHXjx99OE76bL3uK",
    "Botersla (Albert Heijn)": "lepPbDwtYnKVQ8YEQq7X",
    "Snoepgroente Paprika Mix (Albert Heijn)": "lik9rXYwW2CvSqBXHfgs",
    "Pizza Margherita (Crosta & Mollica)": "llBTEIv0A5UhX6cs5uFG",
    "Gnocchi di Patate (De Cecco)": "lqG30jlIOS6162JEj5sR",
    "Chopped Tomatoes Garlic & Onion (Albert Heijn)": "mM1ZwFoDAIJnzP3eGo7k",
    "Pickles (Kesbeke)": "mRmvxV9ZFrd1bpiWG0ct",
    "Smoked Trout (Streeckgenoten)": "mpZHJFYjbvQpJC2FTfKf",
    "Big Mac (McDonald's)": "mwnyaPykodJNKuIpzlH1",
    "Skyr Lemon Cheesecake (Ísey Skyr)": "myNUvRCokIFTxjKLHN3x",
    "Sweet Potato (Jumbo)": "nAar7RdNcS2exvfM6PJE",
    "Medjoul Dates (Albert Heijn)": "nE2rQ5Mx7jDkcBxz6sNN",
    "Spaghetti Bolognese (Daily Flavors)": "nGs1ydS7dVPcTPwBHK3r",
    "Protein Bar Cookies & Cream (Barebells)": "ndR665acPv54twXPu2SK",
    "Philadelphia Light (Philadelphia)": "oGafK6idT3R7l1fTjJyk",
    "Tantanmen Beef Brisket (Wagamama)": "oyTfytCcvX49LeDxYCOk",
    "Sweet Potato Mash, Beef Burger & Broccoli Mix (Fuel Your Body)":
        "p1kyyu36UBHp3dblbKB7",
    "Beef Steak (Future Food Group)": "p6e89pvBd9980lf8pvNW",
    "Kip Teriyaki, Rijst & Broccoli (Muscle Meals)": "piVHOvaxmOU5EUPGccUG",
    "Duitse Biefstuk (Jumbo)": "pk4UWgc5QJfY6puRLmD0",
    "Havermeel (De Notenshop)": "plALoEoeXDPpPv6bHFma",
    "Protein Bar Cookies & Cream (XXL Nutrition)": "por41CI5DZjJS2RxbCEo",
    "Demi Baguette, Sourdough (Albert Heijn)": "psPye5GgSW1s9tefPp5O",
    "Hoisin Sauce (Conimex)": "q8vIpI9A3qW5p6qJZHJx",
    "Chives (Albert Heijn)": "qQ6DVxdXByrgw56XoxXn",
    "Potato (null)": "qZ5CAOycgKYOga9CdL1i",
    "Ciabatta (Albert Heijn)": "qZAR3S0X7cEiJSRbhgKK",
    "Smoked Salmon (Albert Heijn)": "qiIOBraNGT2tfobkiW9r",
    "Paprika Powder (Albert Heijn)": "r0OovubDu8RQuvETQ9VM",
    "Granola Protein Crunch (Holie)": "r4jeR116rKEMQyl9jFd3",
    "Crunchy Muesli Fruit & Nuts (Holie)": "r6dJJSXTKC2OLWzOnWiV",
    "Corn Starch (Koopmans)": "rHRmRVAISC8OA6sMahrs",
    "Börek Spinach & Feta (IKRA Bakeries)": "rHswC33D59SEcFfYiifc",
    "Protein Bar Salted Caramel (Fulfil)": "rfT9082dbM9TSral3C0X",
    "Tikka Masala Paste (Patak's)": "rl0iMzxGwofH2TWafhtz",
    "Orange Juice (null)": "rrNUBUN6ojaXtmo7x8gy",
    "N' Joy Drink Vanilla (XXL Nutrition)": "rtCw00pubUySVDf7LyUt",
    "Brinta Volkoren (Brinta)": "sAgw3v7cIg9PlR2r5ZIG",
    "Roomboter Ongezout (De Zaanse Hoeve)": "sNhZlPrR8ewuaY8rbmDu",
    "Oat Milk Barista (Oatly)": "smvxHlPirnOzZZjXdIuo",
    "Zaanse Mayonaise (Van Wijngaarden)": "ssh497XAMelMPHtSGWqm",
    "Garlic Powder (null)": "tDlmonCNBd8tgrUGAJWV",
    "Teriyaki Chicken Donburi (Wagamama)": "tMXDlEGZMyygaK9JdOmp",
    "Snoepgroente Komkommer (Albert Heijn)": "tOlxk6kRvCxfljeI1AHx",
    "Premium Pilsener (Heineken)": "tQ0eDqbz4IW1u7Fddwiv",
    "Avocado Pesto Dip (Hello Fresh)": "tc0ydB38YM1HAYAQhc1Y",
    "Bean Sprouts (Albert Heijn)": "tcMvf8JxTqIaZKYXibm3",
    "Burger Spicy Bean (Nom Nom Nom)": "tyYtjUUpstrDSHPmsZi5",
    "Chorizo (Hello Fresh)": "u3x4PAoAXk43K09pVcac",
    "Chili Kip Surinaamse Rijst Groente Bulk (Prep the Food)":
        "u72nIjNbq4FPs8ztzoHo",
    "Cottage Cheese (Danone)": "uUN34BiBIcRTB2Lpg7G7",
    "Zeewier Rijstcrackers (Albert Heijn)": "uegWuLnOvsUV6p6req6e",
    "Protein Bar Chocolate (XXL Nutrition)": "uuP3ZxGopHFgeGkefMd7",
    "Pudding Salted Caramel (Melkunie)": "uyLl59Nu1NGbAnyWsQzc",
    "Semi-Skimmed Milk (De Zaanse Hoeve)": "vEwFmJdIeycrvWmPSN3k",
    "Iodized Salt (Albert Heijn)": "vJX60JVIrPOKINCJEKHJ",
    "Indian Curry (Muscle Meals)": "vM7mcCdCsfuG9a5hksnV",
    "Gouda Aged 48+ (Albert Heijn)": "vhEbZwYftIGaP5Reo5ND",
    "Peanut Butter (Calvé)": "vtRmQISIpld0kzog0kkU",
    "Onion (Albert Heijn)": "vzvKVFDR74hQqu1IJGFy",
    "Peanut Butter Smooth (Gorillas)": "w67LGE2DkbBz2a7BJZf1",
    "Dark Chocolate Caramel (Lindt)": "w6GNqzHV0YXSyyNzmLCT",
    "Hagelslag Melk (De Ruiter)": "wBoxDf48vZP6toVbDTj5",
    "Twix (Nestlé)": "wg6OtpbMkdsH4SaWtrmZ",
    "Eggplant (null)": "wp306g6pUopxCJ6tXM2q",
    "Instant Yeast (Doves Farm)": "wrbnOAr2iPpGv8ob2frn",
    "Fresh Foodie Risotto Pumpkin & Chicken (Gorillas)": "wzfjdMTCUAcbyYXGTwDA",
    "Espresso (null)": "x672tETb64YVAocAQl2w",
    "Iceberg Lettuce (Albert Heijn)": "x8SXmhXjCa2BbK5gM6Tp",
    "Roasted Salted Almonds (Jumbo)": "xF3BqDisoVKuVDByPqb6",
    "Ginger Beer (Bundaberg)": "xYHv4JWx1E4ZqFBMc5mV",
    "Orange Zest (null)": "xkGQxRExY151aw5aWQ28",
    "Nesquik (Nestlé)": "xt9rqd7tZks621POJoUX",
    "Sambal Badjak (Conimex)": "y1Qh3zhzf8bRtECJhuQO",
    "Egg White (Two Chicks)": "y2g5JS7a1v3x75Wm86Yx",
    "Strawberries (Fuel Your Body)": "y8NSLfjAApeaTTL2rUai",
    "Snack a Jacks Barbecue Paprika Mini (Snack a Jacks)":
        "yF15kfHMdmM01kF9UdYx",
    "Tomato Frito (Heinz)": "yIwpDYd312xPnQE0TI3Q",
    "Sage (null)": "ybRId8Od3CIzjAWjGtPJ",
    "Cinnamon (null)": "ymYnUsnq8iKhHHZiUIv0",
    "Soy Sauce (Kikkoman)": "z57KanE9EmGebPFuROl1",
    "Burrito BBQ Chicken (No Fairytales)": "zCUtZkABsSvOANp7t4Ak",
    "Marjoram, Dried (null)": "zJTUzc1mlWkVN5J63bSl",
    "Passion Fruit (Albert Heijn)": "zPLLboMWSeuN8JkfsIlk",
    "Udon Noodles (Saitaku)": "zTq0dXbloks0RAb1eHsz",
    "Kipfilet Pittig (Albert Heijn)": "zhPUQ4VpgYmaaZZdXD0j",
  };

  idsByName = {
    ...idsByName,
    "Carrots (Jumbo)": idsByName["Carrots (Albert Heijn)"]!,
    "Coffee (null)": idsByName["Espresso (null)"]!,
    "Dried Marjoram (null)": idsByName["Marjoram, Dried (null)"]!,
    "Egg Free-Range (Albert Heijn)": idsByName["Egg (Albert Heijn)"]!,
    "Ei Scharrel (Albert Heijn)": idsByName["Egg (Albert Heijn)"]!,
    "Ground Steak (Jumbo)": idsByName["Duitse Biefstuk (Jumbo)"]!,
    "Melk Halfvol (De Zaanse Hoeve)":
        idsByName["Semi-Skimmed Milk (De Zaanse Hoeve)"]!,
    "Minced Steak (Jumbo)": idsByName["Duitse Biefstuk (Jumbo)"]!,
    "Scharrelei (Albert Heijn)": idsByName["Egg (Albert Heijn)"]!,
    "Sushi Rijst (Albert Heijn)": idsByName["Sushi Rice (Albert Heijn)"]!,
  };

  var path = idsByName['${map['name']} (${map['brand']})'];

  if (path == null) {
    throw Exception(
      "Reference for ingredient '${map['name']} (${map['brand']})' not found.",
    );
  }

  return FirebaseFirestore.instance
      .collection('users/ZSBLclXCH8euEBERCPSNltS4Yvl2/ingredients')
      .doc(path);
}
