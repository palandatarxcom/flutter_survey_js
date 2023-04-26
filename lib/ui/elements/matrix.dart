import 'package:flutter/material.dart';
import 'package:flutter_survey_js/ui/reactive/reactive_nested_form.dart';
import 'package:flutter_survey_js_model/flutter_survey_js_model.dart' as s;
import 'package:reactive_forms/reactive_forms.dart';

import 'question_title.dart';

Widget matrixBuilder(context, element, {bool hasTitle = true}) {
  return MatrixElement(
    formControlName: element.name!,
    matrix: element as s.Matrix,
  ).wrapQuestionTitle(element, hasTitle: hasTitle);
}

class MatrixElement extends StatelessWidget {
  final String formControlName;
  final s.Matrix matrix;

  const MatrixElement(
      {Key? key, required this.formControlName, required this.matrix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactiveNestedForm(
      formControlName: formControlName,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        List<TableRow> list = <TableRow>[];

        /// Add title bar
        list.add(TableRow(
            decoration: const BoxDecoration(
              color: Colors.grey,
            ),
            children: [
              const TableCell(child: Text('')),
              ...((matrix.columns?.toList() ?? []).map((e) => TableCell(
                    child: _MatrixTitle(e.castToItemvalue()),
                  )))
            ]));
        (matrix.rows?.toList() ?? []).asMap().forEach((i, row) {
          list.add(TableRow(
              decoration: i % 2 != 0
                  ? const BoxDecoration(
                      color: Colors.grey,
                    )
                  : null,
              children: [
                //Row name
                TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Text(row.castToItemvalue().text ?? "")),
                ...(matrix.columns?.toList() ?? []).map((column) {
                  // matrix use the same row control
                  return TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: ReactiveRadioListTile(
                        formControlName: row.castToItemvalue().value.toString(),
                        value: column.castToItemvalue().value?.value),
                  );
                }).toList()
              ]));
        });

        return Table(
          defaultColumnWidth: const IntrinsicColumnWidth(),
          border: TableBorder.all(
            width: 1.0,
          ),
          // columnWidths: map,
          children: list,
        );
      }),
    );
  }
}

// Class _MatrixTitle
class _MatrixTitle extends StatelessWidget {
  final s.Itemvalue column;

  const _MatrixTitle(this.column);

  @override
  Widget build(BuildContext context) {
    return Text(column.text ?? column.value?.toString() ?? "",
        softWrap: true, style: Theme.of(context).textTheme.titleMedium);
  }
}
