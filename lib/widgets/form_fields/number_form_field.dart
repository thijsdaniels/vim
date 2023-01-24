import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberFormField extends TextFormField {
  NumberFormField({
    super.key,
    super.controller,
    num? initialValue,
    super.focusNode,
    super.decoration,
    // super.keyboardType,
    super.textCapitalization,
    super.textInputAction,
    super.style,
    super.strutStyle,
    super.textDirection,
    super.textAlign,
    super.textAlignVertical,
    super.autofocus,
    super.readOnly,
    super.toolbarOptions,
    super.showCursor,
    super.obscuringCharacter,
    super.obscureText,
    super.autocorrect,
    super.smartDashesType,
    super.smartQuotesType,
    super.enableSuggestions,
    super.maxLengthEnforcement,
    super.maxLines,
    super.minLines,
    super.expands,
    super.maxLength,
    void Function(num?)? onChanged,
    super.onTap,
    super.onEditingComplete,
    void Function(num?)? onFieldSubmitted,
    void Function(num?)? onSaved,
    String? Function(num?)? validator,
    // super.inputFormatters,
    super.enabled,
    super.cursorWidth,
    super.cursorHeight,
    super.cursorRadius,
    super.cursorColor,
    super.keyboardAppearance,
    super.scrollPadding,
    super.enableInteractiveSelection,
    super.selectionControls,
    super.buildCounter,
    super.scrollPhysics,
    super.autofillHints,
    super.autovalidateMode,
    super.scrollController,
    super.restorationId,
    super.enableIMEPersonalizedLearning,
    super.mouseCursor,
  }) : super(
          initialValue: initialValue?.toString(),
          onChanged: (value) => onChanged != null
              ? onChanged(value.isNotEmpty ? num.parse(value) : null)
              : null,
          onFieldSubmitted: onFieldSubmitted != null
              ? (value) =>
                  onFieldSubmitted(value.isNotEmpty ? num.parse(value) : null)
              : null,
          onSaved: onSaved != null
              ? (value) => onSaved(
                  value != null && value.isNotEmpty ? num.parse(value) : null)
              : null,
          validator: validator != null
              ? (value) => validator(
                  value != null && value.isNotEmpty ? num.parse(value) : null)
              : null,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
          ],
        );
}
