import 'package:flutter/material.dart';
import 'package:flutter_survey_js/survey.dart';
import 'package:flutter_survey_js/ui/validators.dart';
import 'package:flutter_survey_js_model/flutter_survey_js_model.dart' as s;
import 'package:reactive_forms/reactive_forms.dart';

Object? tryGetValue(String name, Object? value) {
  if (value == null) return null;
  if (value is Map<String, Object?>) {
    return value[name];
  }
  return null;
}

// elementsToFormGroup mapping question json elements to FormGroup
// [value] default value passed down by parent
FormGroup elementsToFormGroup(
    BuildContext context, List<s.Elementbase> elements,
    {Map<s.Elementbase, Object>? controlsMap,
    List<ValidatorFunction> validators = const [],
    List<AsyncValidatorFunction> asyncValidators = const [],
    Object? value}) {
  final Map<String, Object> controls = <String, Object>{};
  final newValidators = [...validators];
  for (var element in elements) {
    //the behavior of panel seems different from previous version --2023/04/26 Goxiaoy
    if (element.name != null && element is! s.Panel) {
      final obj = toFormObject(context, element,
          controlsMap: controlsMap, value: tryGetValue(element.name!, value));
      controls[element.name!] = obj;
      if (controlsMap != null) {
        controlsMap[element] = obj;
      }
    } else {
      //patch parent
      final obj = toFormObject(context, element,
          controlsMap: controlsMap, value: value);
      if (obj is FormGroup) {
        controls.addAll(obj.controls);
      }
    }
    if (element is s.Selectbase) {
      final commentName = "${element.name}-Comment";
      //always add comment control for selectbase, so that the answer patch will work
      controls[commentName] = fb.control<String>(
          "", [if (element.isRequired ?? false) NonEmptyValidator.get]);
    }
  }
  return fb.group(controls, newValidators, asyncValidators);
}

Object? getDefaultValue(s.Elementbase element, Object? value) {
  if (element is s.Question) {
    return element.defaultValue?.value ?? value;
  }
  return value;
}

// toFormObject convert question json element to FromControl
// [value] default value passed down by parent
Object toFormObject(BuildContext context, s.Elementbase element,
    {Map<s.Elementbase, Object>? controlsMap, Object? value}) {
  final obj =
      ((SurveyConfiguration.of(context)?.factory) ?? SurveyElementFactory())
          .resolveFormControl(context, element, value: value);
  if (controlsMap != null) {
    controlsMap[element] = obj;
  }
  return obj;
}

String? getErrorTextFromFormControl<T>(
    BuildContext context, AbstractControl<T> control) {
  if (control.touched && control.hasErrors) {
    final errorKey = control.errors.keys.first;
    final formConfig = ReactiveFormConfig.of(context);

    final validationMessage = formConfig?.validationMessages[errorKey];
    return validationMessage != null
        ? validationMessage(control.getError(errorKey)!)
        : errorKey;
  }
  return null;
}
