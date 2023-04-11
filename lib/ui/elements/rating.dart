import 'package:flutter/material.dart';
import 'package:flutter_survey_js/survey.dart' as s;
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_segmented_control/reactive_segmented_control.dart';

import 'question_title.dart';
import 'survey_element_factory.dart';

final SurveyElementBuilder ratingBuilder =
    (context, element, {bool hasTitle = true}) {
  final e = element as s.Rating;

  final textStyle = Theme.of(context)
      .textTheme
      .bodyText2
      ?.copyWith(color: Theme.of(context).primaryColor);

  Map<int, Widget> getChildren({required int? selectedValue}) {
    final children = <int, Widget>{};
    if (e.rateValues != null && e.rateValues!.length > 0) {
      for (final v in e.rateValues!) {
        children[v.value] = Text(
          v.text ?? v.value?.toString() ?? '',
          style: textStyle,
        );
      }
    } else {
      //use max, min, step
      final maxValue = e.rateMax ?? 5;
      final min = e.rateMin ?? 1;
      final step = e.rateStep ?? 1;
      var current = min;
      while (current <= maxValue) {
        children[current] = Text(
          current.toString(),
          style: selectedValue == current
              ? textStyle?.copyWith(color: Colors.white)
              : textStyle,
        );
        current += step;
      }
    }
    return children;
  }

  return ReactiveValueListenableBuilder<int?>(
    formControlName: element.name!,
    builder: (context, control, child) {
      return ReactiveSegmentedControl<int, int>(
        formControlName: element.name!,
        validationMessages: {'required': (error) => '必填'},
        children: getChildren(selectedValue: control.value),
      ).wrapQuestionTitle(element, hasTitle: hasTitle);
    },
  );
};
