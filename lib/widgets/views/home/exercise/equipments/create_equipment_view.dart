import 'package:flutter/material.dart';
import 'package:vim/models/exercise/equipment.dart';
import 'package:vim/models/mass.dart';
import 'package:vim/services/equipments_collection.dart';
import 'package:vim/widgets/atoms/number_form_field.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/simple_card.dart';
import 'package:vim/widgets/views/onboarding_view.dart';

class CreateEquipmentView extends StatefulWidget {
  final Equipment? equipment;

  const CreateEquipmentView({super.key, this.equipment});

  @override
  State<CreateEquipmentView> createState() => _CreateEquipmentViewState();
}

class _CreateEquipmentViewState extends State<CreateEquipmentView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _name;
  double? _baseWeight = 0;
  double? _weightIncrement = 0;
  double _loadFactor = 1;

  @override
  void initState() {
    super.initState();

    Equipment? equipment = widget.equipment;

    if (equipment != null) {
      _name = equipment.name;
      _baseWeight = equipment.baseWeight.kilograms;
      _weightIncrement = equipment.weightIncrement.kilograms;
      _loadFactor = equipment.loadFactor;
    }
  }

  @override
  Widget build(BuildContext context) {
    Equipment? equipment = widget.equipment;

    return Scaffold(
      appBar: AppBar(
        title: equipment != null
            ? Text(equipment.name)
            : const Text('Create Equipment'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              FormState formState = _formKey.currentState!;

              if (formState.validate()) {
                formState.save();

                Equipment? equipment = widget.equipment;

                if (equipment != null) {
                  equipment.name = _name!;
                  equipment.baseWeight = Mass.kilograms(_baseWeight!);
                  equipment.weightIncrement = Mass.kilograms(_weightIncrement!);
                  equipment.loadFactor = _loadFactor;

                  EquipmentsCollection.of(context).update(equipment);
                } else {
                  EquipmentsCollection.of(context).create(Equipment(
                    name: _name!,
                    baseWeight: Mass.kilograms(_baseWeight!),
                    weightIncrement: Mass.kilograms(_weightIncrement!),
                    loadFactor: _loadFactor,
                  ));
                }

                Navigator.of(context).pop(equipment);
              }
            },
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: StandardList(
          children: [
            SimpleCard(
              title: 'Details',
              child: StandardList(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                spacing: 16,
                children: [
                  TextFormField(
                    autofocus: true,
                    initialValue: _name,
                    onChanged: (name) => setState(() {
                      _name = name;
                    }),
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name.';
                      }
                      return null;
                    },
                  ),
                  NumberFormField(
                    initialValue: _baseWeight,
                    onChanged: (baseWeight) => setState(() {
                      _baseWeight = baseWeight?.toDouble();
                    }),
                    decoration: const InputDecoration(
                      labelText: 'Base Weight',
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null) {
                        return 'Please enter a base weight.';
                      }
                      return null;
                    },
                  ),
                  NumberFormField(
                    initialValue: _weightIncrement,
                    onChanged: (weightIncrement) => setState(() {
                      _weightIncrement = weightIncrement?.toDouble();
                    }),
                    decoration: const InputDecoration(
                      labelText: 'Weight Increment',
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null) {
                        return 'Please enter a weight increment.';
                      }
                      return null;
                    },
                  ),
                  SliderFormField(
                    value: _loadFactor,
                    onChanged: (loadFactor) => setState(() {
                      _loadFactor = loadFactor;
                    }),
                    label: const Text('Load Factor'),
                    max: 2.0,
                    divisions: 40,
                    valueLabel: _loadFactor.toStringAsFixed(2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
