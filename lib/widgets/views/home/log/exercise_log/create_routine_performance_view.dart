import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/date_model.dart';
import 'package:vim/models/exercise/routine.dart';
import 'package:vim/models/exercise/routine_performance.dart';
import 'package:vim/services/performances_service.dart';
import 'package:vim/widgets/atoms/routine_dropdown_menu.dart';
import 'package:vim/widgets/molecules/simple_card.dart';

class CreateRoutinePerformanceView extends StatefulWidget {
  final RoutinePerformance? routinePerformance;

  const CreateRoutinePerformanceView({super.key, this.routinePerformance});

  @override
  State<CreateRoutinePerformanceView> createState() =>
      _CreateRoutinePerformanceViewState();
}

class _CreateRoutinePerformanceViewState
    extends State<CreateRoutinePerformanceView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Routine? _routine;

  @override
  Widget build(BuildContext context) {
    RoutinePerformance? routinePerformance = widget.routinePerformance;

    return Scaffold(
      appBar: AppBar(
        title: routinePerformance != null
            ? Text(routinePerformance.name)
            : const Text('Track Routine'),
        actions: [
          Consumer<DateModel>(
            builder: (context, dateModel, child) => IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                final navigator = Navigator.of(context);

                FormState formState = _formKey.currentState!;

                if (formState.validate()) {
                  formState.save();

                  RoutinePerformance? routinePerformance =
                      widget.routinePerformance;

                  if (routinePerformance != null) {
                    routinePerformance.routine = _routine!;
                  } else {
                    routinePerformance = _routine!.performance(
                      timestamp: dateModel.timestamp,
                    );
                  }

                  navigator.pop(routinePerformance);
                }
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SimpleCard(
              title: 'Details',
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (widget.routinePerformance == null)
                    RoutineDropdownMenu(
                      initialSelection: _routine,
                      onSelected: (routine) {
                        setState(() {
                          _routine = routine;
                        });
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
