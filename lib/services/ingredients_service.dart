import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/services/service.dart';

class IngredientsService extends Service<Ingredient> {
  static IngredientsService of(BuildContext context) {
    return Provider.of<IngredientsService>(context, listen: false);
  }

  IngredientsService(User? user)
      : super(
            path: user != null
                ? 'users/${user.reference!.id}/ingredients'
                : 'ingredients');

  @override
  Ingredient fromFirestore(snapshot, options) {
    return Ingredient.fromSnapshot(snapshot);
  }
}
