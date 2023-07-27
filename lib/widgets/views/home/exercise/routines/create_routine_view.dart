import 'package:flutter/material.dart';
import 'package:vim/models/exercise/routine.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/services/routines_collection.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/simple_card.dart';

class CreateRoutineView extends StatefulWidget {
  final Routine? routine;

  const CreateRoutineView({super.key, this.routine});

  @override
  State<CreateRoutineView> createState() => _CreateRoutineViewState();
}

class _CreateRoutineViewState extends State<CreateRoutineView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name = '';

  @override
  void initState() {
    super.initState();

    Routine? routine = widget.routine;

    if (routine != null) {
      _name = routine.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    Routine? routine = widget.routine;

    return Scaffold(
      appBar: AppBar(
        title:
            routine != null ? Text(routine.name) : const Text('Create Routine'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async {
              FormState formState = _formKey.currentState!;

              if (formState.validate()) {
                formState.save();

                Routine? routine = widget.routine;

                if (routine != null) {
                  routine.name = _name;

                  RoutinesCollection.of(context).update(routine);
                } else {
                  routine = Routine(
                    user: User.of(context).reference!,
                    name: _name,
                    exerciseReferences: [],
                  );

                  RoutinesCollection.of(context).create(routine);
                }

                Navigator.of(context).pop(routine);
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: StandardList(
          children: [
            SimpleCard(
              title: 'Details',
              child: Column(
                children: [
                  TextFormField(
                    autofocus: true,
                    initialValue: _name,
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
                    onChanged: (name) {
                      setState(() {
                        _name = name;
                      });
                    },
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
