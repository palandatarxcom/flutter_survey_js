// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_survey_js/survey.dart' as s;

void main() async {
  var survey = '''
{
"title": "Survey Form for Commune",
"description": "Survey for commune level users",
"logoFit": "cover",
"logoPosition": "right",
"pages": [
{
"name": "Page1",
"elements": [
{
"type": "matrixdynamic",
"name": "question1",
"title": "Question 1",
"columns": [
{
"name": "Column 1"
},
{
"name": "Column 2"
},
{
"name": "Column 3"
}
],
"choices": [
1,
2,
3,
4,
5
]
}
],
"title": "I. COUVERTURE DES RISQUES SOCIAUX",
"description": "Tableau001 : Couverture dela population par les mutuelles sociales toutes prestations (Une liste demutuelle sera fournie)"
},
{
"name": "page2",
"elements": [
{
"type": "matrixdynamic",
"name": "question2",
"title": "Question1",
"columns": [
{
"name": "Column 1"
},
{
"name": "Column 2"
},
{
"name": "Column 3"
}
],
"choices": [
1,
2,
3,
4,
5
]
}
],
"title": "1.2. Assurance Maladie Obligatoire (AMO)",
"description": "Tableau 002 : Couverture de la population par l’AMO (interopérabilité entre le SISo et la base de la CANAM)"
}
]
}
''';
  runApp(SurveyTestApp(surveyJson: survey));
}

class SurveyTestApp extends StatelessWidget {
  const SurveyTestApp({
    key,
    required this.surveyJson,
  });

  final String surveyJson;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Survey Test',
      localizationsDelegates: const [
        ...GlobalMaterialLocalizations.delegates,
        s.MultiAppLocalizationsDelegate(),
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('zh', ''),
      ],
      home: SurveyTestPage(surveyJson: surveyJson),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SurveyTestPage extends StatelessWidget {
  SurveyTestPage({Key? key, required this.surveyJson}) : super(key: key);

  final String surveyJson;

  final Map<String, dynamic> _data = {
    "question1": [
      {"Column 1": null, "Column 2": null, "Column 3": null}
    ],
    "question2": []
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: null,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: s.SurveyWidget(
              survey: s.surveyFromJson(json.decode(surveyJson))!,
              answer: _data,
              onChange: (v) {
                print(v);
              },
              onSubmit: (v) async {
                print('!!!submit!!!\n$v');
              },
              onErrors: (v) async {
                print('!!!errors!!!\n$v');
              },
            ),
          ),
        ),
      ),
    );
  }
}
