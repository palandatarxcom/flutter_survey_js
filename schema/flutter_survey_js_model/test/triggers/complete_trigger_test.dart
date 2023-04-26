import 'package:flutter_survey_js_model/flutter_survey_js_model.dart';
import 'package:test/test.dart';

void main() {
  const json = {
    "showQuestionNumbers": "off",
    "triggers": [
      {
        "type": "complete",
        "name": "exit1",
        "operator": "equal",
        "value": "Yes"
      },
      {"type": "complete", "name": "exit2", "operator": "equal", "value": "Yes"}
    ],
    "pages": [
      {
        "title": "What operating system do you use?",
        "questions": [
          {
            "type": "checkbox",
            "name": "opSystem",
            "title": "OS",
            "hasOther": true,
            "choices": ["Windows", "Linux", "Macintosh OSX"]
          },
          {
            "type": "radiogroup",
            "name": "exit1",
            "title": "Do you want to finish the survey?",
            "choices": ["Yes", "No"],
            "colCount": 0
          }
        ]
      },
      {
        "title": "What language(s) are you currently using?",
        "questions": [
          {
            "type": "checkbox",
            "name": "langs",
            "title": "Plese select from the list",
            "colCount": 4,
            "choices": [
              "Javascript",
              "Java",
              "Python",
              "CSS",
              "PHP",
              "Ruby",
              "C++",
              "C",
              "Shell",
              "C#",
              "Objective-C",
              "R",
              "VimL",
              "Go",
              "Perl",
              "CoffeeScript",
              "TeX",
              "Swift",
              "Scala",
              "Emacs List",
              "Haskell",
              "Lua",
              "Clojure",
              "Matlab",
              "Arduino",
              "Makefile",
              "Groovy",
              "Puppet",
              "Rust",
              "PowerShell"
            ]
          },
          {
            "type": "radiogroup",
            "name": "exit2",
            "title": "Do you want to finish the survey?",
            "choices": ["Yes", "No"],
            "colCount": 0
          }
        ]
      },
      {
        "title": "Please enter your name and e-mail",
        "questions": [
          {"type": "text", "name": "name", "title": "Name:"},
          {"type": "text", "name": "email", "title": "Your e-mail"}
        ]
      }
    ]
  };
  test("Serialize Deserialize Survey", () {
    final s = surveyFromJson(json);
    final serialized = surveyToJson(s);
    expect(surveyFromJson(serialized), s);
  });
}
