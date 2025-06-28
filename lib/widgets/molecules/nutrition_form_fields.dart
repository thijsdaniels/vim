import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/widgets/atoms/standard_list.dart';

class NutritionFormFields extends StatelessWidget {
  final NutritionEditingController controller;
  final bool autofocus;
  final double spacing;

  const NutritionFormFields({
    super.key,
    required this.controller,
    this.autofocus = false,
    this.spacing = 16,
  });

  @override
  Widget build(BuildContext context) {
    return StandardList(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        TextFormField(
          controller: controller.calories,
          autofocus: autofocus,
          decoration: const InputDecoration(
            labelText: 'Energy',
            suffixText: 'kcal',
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
          ],
        ),
        TextFormField(
          controller: controller.fats,
          decoration: const InputDecoration(
            labelText: 'Fats',
            suffixText: 'g',
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: TextFormField(
            controller: controller.saturates,
            decoration: const InputDecoration(
              labelText: 'Saturated Fats',
              suffixText: 'g',
            ),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
            ],
          ),
        ),
        TextFormField(
          controller: controller.carbohydrates,
          decoration: const InputDecoration(
            labelText: 'Carbohydrates',
            suffixText: 'g',
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: TextFormField(
            controller: controller.sugars,
            decoration: const InputDecoration(
              labelText: 'Sugars',
              suffixText: 'g',
            ),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: TextFormField(
            controller: controller.fibers,
            decoration: const InputDecoration(
              labelText: 'Dietary Fibers',
              suffixText: 'g',
            ),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
            ],
          ),
        ),
        TextFormField(
          controller: controller.proteins,
          decoration: const InputDecoration(
            labelText: 'Proteins',
            suffixText: 'g',
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
          ],
        ),
        TextFormField(
          controller: controller.salt,
          decoration: const InputDecoration(
            labelText: 'Salt',
            suffixText: 'g',
          ),
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
          ],
        ),
        ExpansionTile(
          title: const Text("Liquids"),
          children: [
            TextFormField(
              controller: controller.water,
              decoration: const InputDecoration(
                labelText: 'Water',
                suffixText: 'g',
              ),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.alcohol,
              decoration: const InputDecoration(
                labelText: 'Alcohol',
                suffixText: '% vol.',
              ),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
          ],
        ),
        ExpansionTile(
          title: const Text("Stimulants"),
          children: [
            TextFormField(
              controller: controller.caffeine,
              decoration: const InputDecoration(
                labelText: 'Caffeine',
                suffixText: 'mg',
              ),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.creatine,
              decoration: const InputDecoration(
                labelText: 'Creatine',
                suffixText: 'mg',
              ),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
          ],
        ),
        ExpansionTile(
          title: const Text("Minerals"),
          children: [
            TextFormField(
              controller: controller.boron,
              decoration: const InputDecoration(
                labelText: 'Boron',
                suffixText: 'µg',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.calcium,
              decoration: const InputDecoration(
                labelText: 'Calcium',
                suffixText: 'mg',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.chromium,
              decoration: const InputDecoration(
                labelText: 'Chromium',
                suffixText: 'µg',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.cobalt,
              decoration: const InputDecoration(
                labelText: 'Cobalt',
                suffixText: 'µg',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.copper,
              decoration: const InputDecoration(
                labelText: 'Copper',
                suffixText: 'µg',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.fluoride,
              decoration: const InputDecoration(
                labelText: 'Fluoride',
                suffixText: 'µg',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.iodine,
              decoration: const InputDecoration(
                labelText: 'Iodine',
                suffixText: 'µg',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.iron,
              decoration: const InputDecoration(
                labelText: 'Iron',
                suffixText: 'mg',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.magnesium,
              decoration: const InputDecoration(
                labelText: 'Magnesium',
                suffixText: 'mg',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.manganese,
              decoration: const InputDecoration(
                labelText: 'Manganese',
                suffixText: 'µg',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.molybdenum,
              decoration: const InputDecoration(
                labelText: 'Molybdenum',
                suffixText: 'µg',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.nickel,
              decoration: const InputDecoration(
                labelText: 'Nickel',
                suffixText: 'µg',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.phosphorus,
              decoration: const InputDecoration(
                labelText: 'Phosphorus',
                suffixText: 'mg',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.potassium,
              decoration: const InputDecoration(
                labelText: 'Potassium',
                suffixText: 'mg',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.selenium,
              decoration: const InputDecoration(
                labelText: 'Selenium',
                suffixText: 'µg',
              ),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.silicon,
              decoration: const InputDecoration(
                labelText: 'Silicon',
                suffixText: 'µg',
              ),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'Sodium',
                suffixText: 'mg',
              ),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.vanadium,
              decoration: const InputDecoration(
                labelText: 'Vanadium',
                suffixText: 'µg',
              ),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.zinc,
              decoration: const InputDecoration(
                labelText: 'Zinc',
                suffixText: 'mg',
              ),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
          ],
        ),
        ExpansionTile(
          title: const Text("Vitamins"),
          children: [
            TextFormField(
              controller: controller.a,
              decoration: const InputDecoration(
                labelText: 'Vitamin A',
                suffixText: 'µg',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.b1,
              decoration: const InputDecoration(
                labelText: 'Vitamin B1 (Thiamin)',
                suffixText: 'mg',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.b2,
              decoration: const InputDecoration(
                labelText: 'Vitamin B2 (Riboflavin)',
                suffixText: 'mg',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.b3,
              decoration: const InputDecoration(
                labelText: 'Vitamin B3 (Niacin)',
                suffixText: 'mg',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.b5,
              decoration: const InputDecoration(
                labelText: 'Vitamin B5 (Pantothenic Acid)',
                suffixText: 'mg',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.b6,
              decoration: const InputDecoration(
                labelText: 'Vitamin B6 (Pyridoxine)',
                suffixText: 'mg',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.b7,
              decoration: const InputDecoration(
                labelText: 'Vitamin B7 (Biotin)',
                suffixText: 'µg',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.b9,
              decoration: const InputDecoration(
                labelText: 'Vitamin B9 (Folic Acid)',
                suffixText: 'µg',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.b12,
              decoration: const InputDecoration(
                labelText: 'Vitamin B12 (Cobalamin)',
                suffixText: 'µg',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.c,
              decoration: const InputDecoration(
                labelText: 'Vitamin C',
                suffixText: 'mg',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.d,
              decoration: const InputDecoration(
                labelText: 'Vitamin D',
                suffixText: 'µg',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.e,
              decoration: const InputDecoration(
                labelText: 'Vitamin E',
                suffixText: 'mg',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: controller.k,
              decoration: const InputDecoration(
                labelText: 'Vitamin K',
                suffixText: 'µg',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class NutritionEditingController {
  late final TextEditingController calories;
  late final TextEditingController fats;
  late final TextEditingController saturates;
  late final TextEditingController carbohydrates;
  late final TextEditingController sugars;
  late final TextEditingController fibers;
  late final TextEditingController proteins;
  late final TextEditingController boron;
  late final TextEditingController calcium;
  late final TextEditingController chromium;
  late final TextEditingController cobalt;
  late final TextEditingController copper;
  late final TextEditingController fluoride;
  late final TextEditingController iodine;
  late final TextEditingController iron;
  late final TextEditingController magnesium;
  late final TextEditingController manganese;
  late final TextEditingController molybdenum;
  late final TextEditingController nickel;
  late final TextEditingController phosphorus;
  late final TextEditingController potassium;
  late final TextEditingController salt;
  late final TextEditingController selenium;
  late final TextEditingController silicon;
  late final TextEditingController vanadium;
  late final TextEditingController zinc;
  late final TextEditingController a;
  late final TextEditingController b1;
  late final TextEditingController b2;
  late final TextEditingController b3;
  late final TextEditingController b5;
  late final TextEditingController b6;
  late final TextEditingController b7;
  late final TextEditingController b9;
  late final TextEditingController b12;
  late final TextEditingController c;
  late final TextEditingController d;
  late final TextEditingController e;
  late final TextEditingController k;
  late final TextEditingController water;
  late final TextEditingController alcohol;
  late final TextEditingController caffeine;
  late final TextEditingController creatine;

  Nutrition get nutrition {
    return Nutrition(
      calories: double.parse(calories.value.text),
      fats: Fats(
        double.parse(fats.value.text),
        saturates: saturates.value.text.isNotEmpty
            ? double.parse(saturates.value.text)
            : null,
      ),
      carbohydrates: Carbohydrates(
        double.parse(carbohydrates.value.text),
        sugars: sugars.value.text.isNotEmpty
            ? double.parse(sugars.value.text)
            : null,
        fibers: fibers.value.text.isNotEmpty
            ? double.parse(fibers.value.text)
            : null,
      ),
      proteins: Proteins(
        double.parse(proteins.value.text),
      ),
      minerals: Minerals(
        boron: boron.value.text.isNotEmpty
            ? double.parse(boron.value.text) / 1000000
            : null,
        calcium: calcium.value.text.isNotEmpty
            ? double.parse(calcium.value.text) / 1000
            : null,
        chromium: chromium.value.text.isNotEmpty
            ? double.parse(chromium.value.text) / 1000000
            : null,
        cobalt: cobalt.value.text.isNotEmpty
            ? double.parse(cobalt.value.text) / 1000000
            : null,
        copper: copper.value.text.isNotEmpty
            ? double.parse(copper.value.text) / 1000000
            : null,
        fluoride: fluoride.value.text.isNotEmpty
            ? double.parse(fluoride.value.text) / 1000000
            : null,
        iodine: iodine.value.text.isNotEmpty
            ? double.parse(iodine.value.text) / 1000000
            : null,
        iron: iron.value.text.isNotEmpty
            ? double.parse(iron.value.text) / 1000
            : null,
        magnesium: magnesium.value.text.isNotEmpty
            ? double.parse(magnesium.value.text) / 1000
            : null,
        manganese: manganese.value.text.isNotEmpty
            ? double.parse(manganese.value.text) / 1000000
            : null,
        molybdenum: molybdenum.value.text.isNotEmpty
            ? double.parse(molybdenum.value.text) / 1000000
            : null,
        nickel: nickel.value.text.isNotEmpty
            ? double.parse(nickel.value.text) / 1000000
            : null,
        phosphorus: phosphorus.value.text.isNotEmpty
            ? double.parse(phosphorus.value.text) / 1000
            : null,
        potassium: potassium.value.text.isNotEmpty
            ? double.parse(potassium.value.text) / 1000
            : null,
        selenium: selenium.value.text.isNotEmpty
            ? double.parse(selenium.value.text) / 1000000
            : null,
        silicon: silicon.value.text.isNotEmpty
            ? double.parse(silicon.value.text) / 1000000
            : null,
        sodium: salt.value.text.isNotEmpty
            ? Minerals.saltToSodium(double.parse(salt.value.text))
            : null,
        vanadium: vanadium.value.text.isNotEmpty
            ? double.parse(vanadium.value.text) / 1000000
            : null,
        zinc: zinc.value.text.isNotEmpty
            ? double.parse(zinc.value.text) / 1000
            : null,
      ),
      vitamins: Vitamins(
        a: a.value.text.isNotEmpty
            ? double.parse(a.value.text) / 1000000
            : null,
        b1: b1.value.text.isNotEmpty
            ? double.parse(b1.value.text) / 1000
            : null,
        b2: b2.value.text.isNotEmpty
            ? double.parse(b2.value.text) / 1000
            : null,
        b3: b3.value.text.isNotEmpty
            ? double.parse(b3.value.text) / 1000
            : null,
        b5: b5.value.text.isNotEmpty
            ? double.parse(b5.value.text) / 1000
            : null,
        b6: b6.value.text.isNotEmpty
            ? double.parse(b6.value.text) / 1000
            : null,
        b7: b7.value.text.isNotEmpty
            ? double.parse(b7.value.text) / 1000000
            : null,
        b9: b9.value.text.isNotEmpty
            ? double.parse(b9.value.text) / 1000000
            : null,
        b12: b12.value.text.isNotEmpty
            ? double.parse(b12.value.text) / 1000000
            : null,
        c: c.value.text.isNotEmpty ? double.parse(c.value.text) / 1000 : null,
        d: d.value.text.isNotEmpty
            ? double.parse(d.value.text) / 1000000
            : null,
        e: e.value.text.isNotEmpty ? double.parse(e.value.text) / 1000 : null,
        k: k.value.text.isNotEmpty
            ? double.parse(k.value.text) / 1000000
            : null,
      ),
      water:
          water.value.text.isNotEmpty ? double.parse(water.value.text) : null,
      alcohol: alcohol.value.text.isNotEmpty
          ? alcoholByWeight(double.parse(alcohol.value.text))
          : null,
      stimulants: Stimulants(
        caffeine: caffeine.value.text.isNotEmpty
            ? double.parse(caffeine.value.text) / 1000
            : null,
        creatine: creatine.value.text.isNotEmpty
            ? double.parse(creatine.value.text) / 1000
            : null,
      ),
    );
  }

  set nutrition(Nutrition nutrition) {
    calories.text = nutrition.calories.toString();
    carbohydrates.text = nutrition.carbohydrates.total?.toString() ?? "";
    fats.text = nutrition.fats.total?.toString() ?? "";
    proteins.text = nutrition.proteins.total?.toString() ?? "";
    saturates.text = nutrition.fats.saturates?.toString() ?? "";
    sugars.text = nutrition.carbohydrates.sugars?.toString() ?? "";
    fibers.text = nutrition.carbohydrates.fibers?.toString() ?? "";
    boron.text = nutrition.minerals.boron != null
        ? ((nutrition.minerals.boron ?? 0) * 1000000).toString()
        : "";
    calcium.text = nutrition.minerals.calcium != null
        ? ((nutrition.minerals.calcium ?? 0) * 1000).toString()
        : "";
    chromium.text = nutrition.minerals.chromium != null
        ? ((nutrition.minerals.chromium ?? 0) * 1000000).toString()
        : "";
    cobalt.text = nutrition.minerals.cobalt != null
        ? ((nutrition.minerals.cobalt ?? 0) * 1000000).toString()
        : "";
    copper.text = nutrition.minerals.copper != null
        ? ((nutrition.minerals.copper ?? 0) * 1000000).toString()
        : "";
    fluoride.text = nutrition.minerals.fluoride != null
        ? ((nutrition.minerals.fluoride ?? 0) * 1000000).toString()
        : "";
    iodine.text = nutrition.minerals.iodine != null
        ? ((nutrition.minerals.iodine ?? 0) * 1000000).toString()
        : "";
    iron.text = nutrition.minerals.iron != null
        ? ((nutrition.minerals.iron ?? 0) * 1000).toString()
        : "";
    magnesium.text = nutrition.minerals.magnesium != null
        ? ((nutrition.minerals.magnesium ?? 0) * 1000).toString()
        : "";
    manganese.text = nutrition.minerals.manganese != null
        ? ((nutrition.minerals.manganese ?? 0) * 1000000).toString()
        : "";
    molybdenum.text = nutrition.minerals.molybdenum != null
        ? ((nutrition.minerals.molybdenum ?? 0) * 1000000).toString()
        : "";
    nickel.text = nutrition.minerals.nickel != null
        ? ((nutrition.minerals.nickel ?? 0) * 1000000).toString()
        : "";
    phosphorus.text = nutrition.minerals.phosphorus != null
        ? ((nutrition.minerals.phosphorus ?? 0) * 1000).toString()
        : "";
    potassium.text = nutrition.minerals.potassium != null
        ? ((nutrition.minerals.potassium ?? 0) * 1000).toString()
        : "";
    salt.text =
        Minerals.sodiumToSalt(nutrition.minerals.sodium)?.toString() ?? "";
    selenium.text = nutrition.minerals.selenium != null
        ? ((nutrition.minerals.selenium ?? 0) * 1000000).toString()
        : "";
    silicon.text = nutrition.minerals.silicon != null
        ? ((nutrition.minerals.silicon ?? 0) * 1000000).toString()
        : "";
    vanadium.text = nutrition.minerals.vanadium != null
        ? ((nutrition.minerals.vanadium ?? 0) * 1000000).toString()
        : "";
    zinc.text = nutrition.minerals.zinc != null
        ? ((nutrition.minerals.zinc ?? 0) * 1000).toString()
        : "";
    a.text = nutrition.vitamins.a != null
        ? ((nutrition.vitamins.a ?? 0) * 1000000).toString()
        : "";
    b1.text = nutrition.vitamins.b1 != null
        ? ((nutrition.vitamins.b1 ?? 0) * 1000).toString()
        : "";
    b2.text = nutrition.vitamins.b2 != null
        ? ((nutrition.vitamins.b2 ?? 0) * 1000).toString()
        : "";
    b3.text = nutrition.vitamins.b3 != null
        ? ((nutrition.vitamins.b3 ?? 0) * 1000).toString()
        : "";
    b5.text = nutrition.vitamins.b5 != null
        ? ((nutrition.vitamins.b5 ?? 0) * 1000).toString()
        : "";
    b6.text = nutrition.vitamins.b6 != null
        ? ((nutrition.vitamins.b6 ?? 0) * 1000).toString()
        : "";
    b7.text = nutrition.vitamins.b7 != null
        ? ((nutrition.vitamins.b7 ?? 0) * 1000000).toString()
        : "";
    b9.text = nutrition.vitamins.b9 != null
        ? ((nutrition.vitamins.b9 ?? 0) * 1000000).toString()
        : "";
    b12.text = nutrition.vitamins.b12 != null
        ? ((nutrition.vitamins.b12 ?? 0) * 1000000).toString()
        : "";
    c.text = nutrition.vitamins.c != null
        ? ((nutrition.vitamins.c ?? 0) * 1000).toString()
        : "";
    d.text = nutrition.vitamins.d != null
        ? ((nutrition.vitamins.d ?? 0) * 1000000).toString()
        : "";
    e.text = nutrition.vitamins.e != null
        ? ((nutrition.vitamins.e ?? 0) * 1000).toString()
        : "";
    k.text = nutrition.vitamins.k != null
        ? ((nutrition.vitamins.k ?? 0) * 1000000).toString()
        : "";
    water.text = nutrition.water?.toString() ?? "";
    alcohol.text = alcoholByVolume(nutrition.alcohol)?.toString() ?? "";
    caffeine.text = nutrition.stimulants.caffeine != null
        ? ((nutrition.stimulants.caffeine ?? 0) * 1000).toString()
        : "";
    creatine.text = nutrition.stimulants.creatine != null
        ? ((nutrition.stimulants.creatine ?? 0) * 1000).toString()
        : "";
  }

  NutritionEditingController({
    TextEditingController? calories,
    TextEditingController? fats,
    TextEditingController? saturates,
    TextEditingController? carbohydrates,
    TextEditingController? sugars,
    TextEditingController? fibers,
    TextEditingController? proteins,
    TextEditingController? boron,
    TextEditingController? calcium,
    TextEditingController? chromium,
    TextEditingController? cobalt,
    TextEditingController? copper,
    TextEditingController? fluoride,
    TextEditingController? iodine,
    TextEditingController? iron,
    TextEditingController? magnesium,
    TextEditingController? manganese,
    TextEditingController? molybdenum,
    TextEditingController? nickel,
    TextEditingController? phosphorus,
    TextEditingController? potassium,
    TextEditingController? salt,
    TextEditingController? selenium,
    TextEditingController? silicon,
    TextEditingController? vanadium,
    TextEditingController? zinc,
    TextEditingController? a,
    TextEditingController? b1,
    TextEditingController? b2,
    TextEditingController? b3,
    TextEditingController? b5,
    TextEditingController? b6,
    TextEditingController? b7,
    TextEditingController? b9,
    TextEditingController? b12,
    TextEditingController? c,
    TextEditingController? d,
    TextEditingController? e,
    TextEditingController? k,
    TextEditingController? water,
    TextEditingController? alcohol,
    TextEditingController? caffeine,
    TextEditingController? creatine,
  }) {
    this.calories = calories ?? TextEditingController();
    this.fats = fats ?? TextEditingController();
    this.saturates = saturates ?? TextEditingController();
    this.carbohydrates = carbohydrates ?? TextEditingController();
    this.sugars = sugars ?? TextEditingController();
    this.fibers = fibers ?? TextEditingController();
    this.proteins = proteins ?? TextEditingController();
    this.boron = boron ?? TextEditingController();
    this.calcium = calcium ?? TextEditingController();
    this.chromium = chromium ?? TextEditingController();
    this.cobalt = cobalt ?? TextEditingController();
    this.copper = copper ?? TextEditingController();
    this.fluoride = fluoride ?? TextEditingController();
    this.iodine = iodine ?? TextEditingController();
    this.iron = iron ?? TextEditingController();
    this.magnesium = magnesium ?? TextEditingController();
    this.manganese = manganese ?? TextEditingController();
    this.molybdenum = molybdenum ?? TextEditingController();
    this.nickel = nickel ?? TextEditingController();
    this.phosphorus = phosphorus ?? TextEditingController();
    this.potassium = potassium ?? TextEditingController();
    this.salt = salt ?? TextEditingController();
    this.selenium = selenium ?? TextEditingController();
    this.silicon = silicon ?? TextEditingController();
    this.vanadium = vanadium ?? TextEditingController();
    this.zinc = zinc ?? TextEditingController();
    this.a = a ?? TextEditingController();
    this.b1 = b1 ?? TextEditingController();
    this.b2 = b2 ?? TextEditingController();
    this.b3 = b3 ?? TextEditingController();
    this.b5 = b5 ?? TextEditingController();
    this.b6 = b6 ?? TextEditingController();
    this.b7 = b7 ?? TextEditingController();
    this.b9 = b9 ?? TextEditingController();
    this.b12 = b12 ?? TextEditingController();
    this.c = c ?? TextEditingController();
    this.d = d ?? TextEditingController();
    this.e = e ?? TextEditingController();
    this.k = k ?? TextEditingController();
    this.water = water ?? TextEditingController();
    this.alcohol = alcohol ?? TextEditingController();
    this.caffeine = caffeine ?? TextEditingController();
    this.creatine = creatine ?? TextEditingController();
  }
}

double specificGravityOfAlcohol = 0.78924;

num? alcoholByWeight(num? alcoholByVolume) {
  return alcoholByVolume != null
      ? alcoholByVolume * specificGravityOfAlcohol
      : null;
}

num? alcoholByVolume(num? alcoholByWeight) {
  return alcoholByWeight != null
      ? alcoholByWeight / specificGravityOfAlcohol
      : null;
}
