import 'package:flutter/material.dart';
import 'package:flutter_survey_js/model/survey.dart' as s;
import 'package:flutter_survey_js/ui/survey_widget.dart';

class QuestionTitle extends StatelessWidget {
  final s.Question q;
  final Widget? child;

  const QuestionTitle({Key? key, required this.q, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    description() {
      if (q.description != null && q.description!.isNotEmpty) {
        return Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
          child: Text(q.description!,
              style: TextStyle(
                  fontFamily: 'SF-UI-Text',
                  color: Theme.of(context).disabledColor //Color(0xff8b9aa9)
                  )),
        );
      } else {
        return Container();
      }
    }
    titleTextStyle() {
      return TextStyle(
          fontSize: 16.0,
          fontFamily: 'SF-UI-Text',
          fontWeight: FontWeight.w900,
          color: Theme.of(context).disabledColor //Color(0xff242833)
          );
    }

    title() {
      List<Widget> listTitle = <Widget>[];
      listTitle.add(Builder(builder: (context) {
        final survey = SurveyProvider.of(context);
        final status = survey.elementsState.get(q);
        if (status != null) {
          if (survey.survey.showQuestionNumbers == "on" &&
              status.indexAll != null) {
            return Text(
              '${status.indexAll! + 1}.',
              style: titleTextStyle(),
            );
          } else if (survey.survey.showQuestionNumbers == "onPage" &&
              status.indexInPage != null) {
            return Text(
              '${status.indexInPage! + 1}.',
              style: titleTextStyle(),
            );
          }
        }

        return Container();
      }));

      if (q.isRequired == true) {
        listTitle.add(Text(
          '* ',
          style: requiredTextStyle,
        ));
      }

      listTitle.add(Expanded(
          child: Text(
        q.title ?? q.name ?? "",
        style: titleTextStyle(),
      )));

      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: listTitle),
          description(),
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title(),
        if (child != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: child!,
          )
      ],
    );
  }

  TextStyle get requiredTextStyle => const TextStyle(
      fontSize: 16.0,
      fontFamily: 'SF-UI-Text',
      fontWeight: FontWeight.w900,
      color: Colors.red);
}

extension QuestionTitleExtension on Widget {
  Widget wrapQuestionTitle(s.ElementBase element, {required bool hasTitle}) {
    if (!hasTitle) {
      //in a matrix
      return this;
    }
    if (element is s.Question) {
      return QuestionTitle(
        q: element,
        child: this,
      );
    }
    return this;
  }
}
