import 'package:flutter/material.dart';
import 'package:flutter_survey_js/survey.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // 单一的测试
  const json = {
    "questions": [
      {
        "type": "multipletext",
        "name": "pricelimit",
        "title": "What is the... ",
        "colCount": 2,
        "items": [
          {
            "name": "mostamount",
            "title": "Most amount you would every pay for a product like ours"
          },
          {
            "name": "leastamount",
            "title": "The least amount you would feel comfortable paying"
          }
        ]
      }
    ]
  };
  test("Serialize Deserialize Survey", () {
    final s = surveyFromJson(json);
  });
  testWidgets('displays placeholders', (WidgetTester tester) async {
    const placeholder1 = 'Write text1 answer here...';
    const placeholder2 = 'Write text2 answer here...';
    final s = surveyFromJson(
      {
        "title": "Single Page Survey",
        "pages": [
          {
            "name": "page1",
            "elements": [
              {
                "type": "multipletext",
                "name": "question1",
                "items": [
                  {
                    "name": "text1",
                    "placeholder": placeholder1,
                  },
                  {
                    "name": "text2",
                    "placeholder": placeholder2,
                  }
                ]
              }
            ]
          }
        ]
      },
    )!;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          MultiAppLocalizationsDelegate(),
        ],
        home: Material(
          child: SurveyWidget(survey: s),
        ),
      ),
    );
    await tester.pump();
    await tester.idle();

    expect(find.text(placeholder1), findsOneWidget);
    expect(find.text(placeholder2), findsOneWidget);
  });
}
