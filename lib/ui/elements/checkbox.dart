import 'package:flutter/material.dart';
import 'package:flutter_survey_js_model/flutter_survey_js_model.dart' as s;
import 'package:reactive_forms/reactive_forms.dart';

import '../../generated/l10n.dart';
import 'question_title.dart';

Widget checkBoxBuilder(context, element, {bool hasTitle = true}) {
  return CheckBoxElement(
    formControlName: element.name!,
    element: element as s.Checkbox,
  ).wrapQuestionTitle(element, hasTitle: hasTitle);
}

class CheckBoxElement extends StatefulWidget {
  final String formControlName;
  final s.Checkbox element;

  const CheckBoxElement(
      {Key? key, required this.formControlName, required this.element})
      : super(key: key);

  static bool allChecked(
      List<s.Itemvalue> choices, List<AbstractControl<Object?>> selected) {
    for (var choice in choices) {
      if (!selected.any((c) => c.value == choice.value?.value)) {
        return false;
      }
    }
    return true;
  }

  static void excludeFrom(FormArray<Object?> formArray, Object obj) {
    final rs = formArray.controls.where((c) => c.value == obj).toList();
    if (rs.isNotEmpty) {
      for (var r in rs) {
        formArray.remove(r);
      }
    }
  }

  @override
  State<CheckBoxElement> createState() => _CheckBoxElementState();
}

class _CheckBoxElementState extends State<CheckBoxElement> {
  bool showOtherTextField = false;
  String oldOtherValue = '';
  void resetOtherItem(List<s.Itemvalue> choices, FormArray<Object?> formArray) {
    bool showOther = false;
    String otherValue = '';
    for (Object? value in formArray.controls.map((e) => e.value)) {
      if (!choices.any((c) => c.value?.value == value)) {
        showOther = true;
        otherValue = value.toString();
      }
    }
    setState(() {
      showOtherTextField = showOther;
      oldOtherValue = otherValue;
    });
  }

  @override
  void initState() {
    super.initState();
    var choices =
        widget.element.choices?.map((p0) => p0.castToItemvalue()).toList() ??
            [];
    var formArray =
        (ReactiveForm.of(context, listen: false) as FormControlCollection)
            .control(widget.formControlName) as FormArray<Object?>;
    resetOtherItem(choices, formArray);
  }

  @override
  Widget build(BuildContext context) {
    List<s.Itemvalue> choices =
        widget.element.choices?.map((p0) => p0.castToItemvalue()).toList() ??
            [];
    return ReactiveFormArray(
        formArrayName: widget.formControlName,
        builder: (context, formArray, child) {
          final list = <Widget>[];
          // showSelectAllItem
          if (widget.element.showSelectAllItem ?? false) {
            String? text =
                widget.element.selectAllText ?? S.of(context).selectAllText;
            list.add(CheckboxListTile(
              value: CheckBoxElement.allChecked(choices, formArray.controls),
              title: Text(text),
              onChanged: (v) {
                formArray.clear();
                resetOtherItem(choices, formArray);
                if (v == true) {
                  formArray.addAll(choices
                      .map((choice) =>
                          FormControl<Object>(value: choice.value?.value))
                      .toList());
                }
              },
            ));
          }
          for (s.Itemvalue element in (widget.element.choices
                  ?.map((p0) => p0.castToItemvalue())
                  .toList() ??
              [])) {
            list.add(CheckboxListTile(
              value: formArray.controls
                  .any((c) => c.value == element.value?.value),
              title: Text(element.text ?? element.value?.toString() ?? ''),
              onChanged: (v) {
                if (v == true) {
                  CheckBoxElement.excludeFrom(formArray, 'none');
                  formArray
                      .add(FormControl<Object>(value: element.value?.value));
                } else {
                  final rs = formArray.controls
                      .where((c) => c.value == element.value?.value)
                      .toList();
                  if (rs.isNotEmpty) {
                    for (var r in rs) {
                      formArray.remove(r);
                    }
                  }
                }
              },
            ));
          }
          // showNoneItem
          if (widget.element.showNoneItem ?? false) {
            String? text =
                widget.element.noneText ?? S.of(context).noneItemText;
            list.add(CheckboxListTile(
              value: formArray.controls.any((c) => c.value == 'none'),
              title: Text(text),
              onChanged: (v) {
                resetOtherItem(choices, formArray);
                if (v == true) {
                  formArray.clear();
                  formArray.add(FormControl<Object>(value: 'none'));
                } else {
                  CheckBoxElement.excludeFrom(formArray, 'none');
                }
              },
            ));
          }
          // showOtherItem
          if (widget.element.showOtherItem ?? false) {
            String? text =
                widget.element.otherText ?? S.of(context).otherItemText;
            list.add(CheckboxListTile(
              value: showOtherTextField,
              title: Text(text),
              onChanged: (v) {
                if (v == true) {
                  CheckBoxElement.excludeFrom(formArray, 'none');
                }
                if (oldOtherValue.isNotEmpty) {
                  CheckBoxElement.excludeFrom(formArray, oldOtherValue);
                }
                setState(() {
                  oldOtherValue = '';
                  showOtherTextField = v ?? false;
                });
              },
            ));
          }
          if (showOtherTextField) {
            list.add(TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: widget.element.otherPlaceholder,
              ),
              initialValue: oldOtherValue,
              onChanged: (value) {
                if (oldOtherValue.isNotEmpty) {
                  CheckBoxElement.excludeFrom(formArray, oldOtherValue);
                }
                if (value.isNotEmpty) {
                  formArray.add(FormControl<Object>(value: value));
                }
                setState(() {
                  oldOtherValue = value;
                });
              },
            ));
          }
          return Column(
            children: list,
          );
        });
  }
}
