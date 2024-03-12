import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/number_form_field.dart';

class IncrementalNumberFormField extends StatelessWidget {
  late final TextEditingController controller;
  final num? stepSize;
  final InputDecoration? decoration;
  final num? initialValue;
  final void Function(num?)? onChanged;
  final TextInputAction? textInputAction;
  final String? Function(num?)? validator;
  final bool autofocus;

  num? get value =>
      controller.text.isNotEmpty ? num.parse(controller.text) : null;

  set value(num? value) {
    controller.text = value.toString();

    if (onChanged != null) {
      onChanged!(value);
    }
  }

  IncrementalNumberFormField({
    super.key,
    TextEditingController? controller,
    this.stepSize = 1,
    this.decoration,
    this.initialValue,
    this.onChanged,
    this.textInputAction,
    this.validator,
    this.autofocus = false,

    // super.focusNode,
    // // super.decoration,
    // // super.keyboardType,
    // super.textCapitalization,
    // super.style,
    // super.strutStyle,
    // super.textDirection,
    // super.textAlign,
    // super.textAlignVertical,
    // super.autofocus,
    // super.readOnly,
    // super.toolbarOptions,
    // super.showCursor,
    // super.obscuringCharacter,
    // super.obscureText,
    // super.autocorrect,
    // super.smartDashesType,
    // super.smartQuotesType,
    // super.enableSuggestions,
    // super.maxLengthEnforcement,
    // super.maxLines,
    // super.minLines,
    // super.expands,
    // super.maxLength,
    // super.onTap,
    // super.onEditingComplete,
    // super.onFieldSubmitted,
    // super.onSaved,
    // // super.inputFormatters,
    // super.enabled,
    // super.cursorWidth,
    // super.cursorHeight,
    // super.cursorRadius,
    // super.cursorColor,
    // super.keyboardAppearance,
    // super.scrollPadding,
    // super.enableInteractiveSelection,
    // super.selectionControls,
    // super.buildCounter,
    // super.scrollPhysics,
    // super.autofillHints,
    // super.autovalidateMode,
    // super.scrollController,
    // super.restorationId,
    // super.enableIMEPersonalizedLearning,
    // super.mouseCursor,
  }) : assert(
          controller == null || initialValue == null,
        ) {
    this.controller = controller ??
        TextEditingController(
          text: initialValue?.toString(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return NumberFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      autofocus: autofocus,
      textInputAction: textInputAction,
      decoration: decoration?.copyWith(
        prefixIcon: IconButton(
          icon: const Icon(Icons.remove),
          onPressed: stepSize != null ? onDecrementPressed : null,
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.add),
          onPressed: stepSize != null ? onIncrementPressed : null,
        ),
      ),
    );
  }

  void onIncrementPressed() {
    value = (value ?? 0) + stepSize!;
  }

  void onDecrementPressed() {
    value = (value ?? 0) - stepSize!;
  }
}
