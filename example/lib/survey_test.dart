// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_survey_js/survey.dart' as s;

void main() async {
  var survey = '''
{
    "title": "抑郁症患者问卷",
    "logoPosition": "right",
    "pages": [
        {
            "name": "page1",
            "elements": [
                {
                    "type": "panel",
                    "name": "002 基本情况",
                    "elements": [
                        {
                            "type": "radiogroup",
                            "name": "003 性别：",
                            "title": "性别：",
                            "isRequired": true,
                            "choices": [
                                "男",
                                "女"
                            ]
                        },
                        {
                            "type": "text",
                            "name": "004 年龄（岁）：",
                            "title": "年龄（岁）：",
                            "isRequired": true,
                            "inputType": "number"
                        },
                        {
                            "type": "dropdown",
                            "name": "问题2",
                            "isRequired": true,
                            "showOtherItem": true,
                            "showNoneItem": true,
                            "otherText": "其他",
                            "noneText": "以上都不是",
                            "choices": [
                              "item1",
                              "item2",
                              "item3"
                            ]
                       }
                    ],
                    "title": "请完善您的基本情况"
                },
                {
                    "type": "panel",
                    "name": "030 治疗期待及关注点",
                    "elements": [
                        {
                            "type": "checkbox",
                            "name": "031 您最希望获得哪些抑郁症相关知识？（最多选三种）",
                            "title": "031 您最希望获得哪些抑郁症相关知识？（最多选三种）",
                            "choices": [
                                "疾病知识",
                                "治疗方案",
                                "预后情况",
                                "复发情况",
                                "药物获益及不良反应",
                                "治疗疗程",
                                "随访情况",
                                "诊疗费用"
                            ],
                            "hasOther": true,
                            "otherText": "其他，请注明：",
                            "maxSelectedChoices": 3
                        },
                        {
                            "type": "radiogroup",
                            "name": "032 您能接受的每月诊疗费用是多少？",
                            "title": "您能接受的每月诊疗费用是多少？",
                            "choices": [
                                "300元以内",
                                "300-500元",
                                "500-1000元",
                                "1000-2000元",
                                "2000元以上"
                            ],
                            "otherText": "其他，请注明："
                        },
                        {
                            "type": "ranking",
                            "name": "037 对药物治疗最主要的关注点的排序：",
                            "title": "对药物治疗最主要的关注点的排序：",
                            "choicesFromQuestion": "035 您在治疗的时候，对药物治疗最主要的关注点是什么？（最多选三种）",
                            "choices": [
                                "item1",
                                "item2",
                                "item3"
                            ],
                            "choicesFromQuestionMode": "selected"
                        },
                        {
                            "type": "checkbox",
                            "name": "Q038",
                            "title": "038 您对抑郁症诊断、治疗及预后最担心的问题是什么？（最多选三种）",
                            "isRequired": true,
                            "choices": [
                                "出现药物不良反应",
                                "出现药物依赖",
                                "治疗费用过高，有经济压力",
                                "治疗后能不能治愈",
                                "治疗后会不会复发",
                                "治疗后能不能回归正常生活，恢复学习能力",
                                "抑郁症会不会遗传",
                                "诊断抑郁症对未来生活产生影响",
                                "其他",
                                "NA"
                            ],
                            "maxSelectedChoices": 3
                        },
                        {
                            "type": "text",
                            "name": "039 其他对抑郁症诊断、治疗及预后最担心的问题：",
                            "visibleIf": "{Q038} anyof ['NA']",
                            "title": "039 其他对抑郁症诊断、治疗及预后最担心的问题："
                        },
                        {
                            "type": "checkbox",
                            "name": "042 您了解的心里治疗方法有哪些？（多选题）",
                            "title": "042 您了解的心里治疗方法有哪些？（多选题）",
                            "choices": [
                                "支持性心理治疗",
                                "动力学心理治疗",
                                "认知疗法",
                                "行为治疗",
                                "人际心理治疗",
                                "婚姻和家庭治疗 "
                            ],
                            "hasOther": true,
                            "hasNone": true,
                            "noneText": "上述方法都不了解",
                            "otherText": "其他，请注明："
                        }
                    ],
                    "title": "请留下您对抗抑郁治疗的期待及关注点，帮助医生更准确获取您的需求"
                },
                {
                    "type": "panel",
                    "name": "043 药物治疗后对情绪、躯体、认知等方面的改善",
                    "elements": [
                        {
                            "type": "rating",
                            "name": "044 您希望药物治疗后能快感确实改善",
                            "title": "044 您希望药物治疗后能回归日常生活及社交中，并在其中感受到乐趣、感受到生命有意义、能享受生活",
                            "rateMin": 0,
                            "rateMax": 10,
                            "visibleIf": "{Q038} anyof ['NA']",
                            "minRateDescription": "非常不迫切",
                            "maxRateDescription": "非常迫切"
                        },
                        {
                            "type": "rating",
                            "name": "045 您希望药物治疗后能改善心境持续低落",
                            "title": "045 您希望药物治疗后能改善心境持续低落，如：常哭泣，自我评价低，无助感等症状",
                            "rateMin": 0,
                            "rateMax": 10,
                            "minRateDescription": "非常不迫切",
                            "maxRateDescription": "非常迫切"
                        }
                    ],
                    "title": "规范的药物治疗后会对您的情绪、躯体、认知等方面逐步改善，请您对以下改善",
                    "description": "需求的迫切程度，请按照“非常迫切 10”到“非常不迫切 0”进行选择"
                }
            ]
        },
        {
            "name": "page2",
            "elements": [
                {
                    "type": "panel",
                    "name": "004 基本情况",
                    "elements": [
                        {
                            "type": "radiogroup",
                            "name": "2 003 性别：",
                            "title": "2性别：",
                            "isRequired": true,
                            "choices": [
                                "男",
                                "女"
                            ]
                        },
                        {
                            "type": "text",
                            "name": "2 004 年龄（岁）：",
                            "title": "2年龄（岁）：",
                            "isRequired": true,
                            "inputType": "number"
                        },
                        {
                            "type": "dropdown",
                            "name": "2 问题2",
                            "isRequired": true,
                            "choices": [
                              "item1",
                              "item2",
                              "item3"
                            ]
                       }
                    ],
                    "title": "请完善您的基本情况"
                },
                {
                    "type": "panel",
                    "name": "030 治疗期待及关注点",
                    "elements": [
                        {
                            "type": "checkbox",
                            "name": "031 您最希望获得哪些抑郁症相关知识？（最多选三种）",
                            "title": "031 您最希望获得哪些抑郁症相关知识？（最多选三种）",
                            "choices": [
                                "疾病知识",
                                "治疗方案",
                                "预后情况",
                                "复发情况",
                                "药物获益及不良反应",
                                "治疗疗程",
                                "随访情况",
                                "诊疗费用"
                            ],
                            "hasOther": true,
                            "otherText": "其他，请注明：",
                            "maxSelectedChoices": 3
                        },
                        {
                            "type": "radiogroup",
                            "name": "032 您能接受的每月诊疗费用是多少？",
                            "title": "您能接受的每月诊疗费用是多少？",
                            "choices": [
                                "300元以内",
                                "300-500元",
                                "500-1000元",
                                "1000-2000元",
                                "2000元以上"
                            ],
                            "otherText": "其他，请注明："
                        },
                        {
                            "type": "ranking",
                            "name": "037 对药物治疗最主要的关注点的排序：",
                            "title": "对药物治疗最主要的关注点的排序：",
                            "choicesFromQuestion": "035 您在治疗的时候，对药物治疗最主要的关注点是什么？（最多选三种）",
                            "choices": [
                                "item1",
                                "item2",
                                "item3"
                            ],
                            "choicesFromQuestionMode": "selected"
                        },
                        {
                            "type": "checkbox",
                            "name": "Q038",
                            "title": "038 您对抑郁症诊断、治疗及预后最担心的问题是什么？（最多选三种）",
                            "isRequired": true,
                            "choices": [
                                "出现药物不良反应",
                                "出现药物依赖",
                                "治疗费用过高，有经济压力",
                                "治疗后能不能治愈",
                                "治疗后会不会复发",
                                "治疗后能不能回归正常生活，恢复学习能力",
                                "抑郁症会不会遗传",
                                "诊断抑郁症对未来生活产生影响",
                                "其他",
                                "NA"
                            ],
                            "maxSelectedChoices": 3
                        },
                        {
                            "type": "text",
                            "name": "039 其他对抑郁症诊断、治疗及预后最担心的问题：",
                            "visibleIf": "{Q038} anyof ['NA']",
                            "title": "039 其他对抑郁症诊断、治疗及预后最担心的问题："
                        },
                        {
                            "type": "checkbox",
                            "name": "042 您了解的心里治疗方法有哪些？（多选题）",
                            "title": "042 您了解的心里治疗方法有哪些？（多选题）",
                            "choices": [
                                "支持性心理治疗",
                                "动力学心理治疗",
                                "认知疗法",
                                "行为治疗",
                                "人际心理治疗",
                                "婚姻和家庭治疗 "
                            ],
                            "hasOther": true,
                            "hasNone": true,
                            "noneText": "上述方法都不了解",
                            "otherText": "其他，请注明："
                        }
                    ],
                    "title": "请留下您对抗抑郁治疗的期待及关注点，帮助医生更准确获取您的需求"
                },
                {
                    "type": "panel",
                    "name": "043 药物治疗后对情绪、躯体、认知等方面的改善",
                    "elements": [
                        {
                            "type": "rating",
                            "name": "044 您希望药物治疗后能快感确实改善",
                            "title": "044 您希望药物治疗后能回归日常生活及社交中，并在其中感受到乐趣、感受到生命有意义、能享受生活",
                            "rateMin": 0,
                            "rateMax": 10,
                            "visibleIf": "{Q038} anyof ['NA']",
                            "minRateDescription": "非常不迫切",
                            "maxRateDescription": "非常迫切"
                        },
                        {
                            "type": "rating",
                            "name": "045 您希望药物治疗后能改善心境持续低落",
                            "title": "045 您希望药物治疗后能改善心境持续低落，如：常哭泣，自我评价低，无助感等症状",
                            "rateMin": 0,
                            "rateMax": 10,
                            "minRateDescription": "非常不迫切",
                            "maxRateDescription": "非常迫切"
                        }
                    ],
                    "title": "规范的药物治疗后会对您的情绪、躯体、认知等方面逐步改善，请您对以下改善",
                    "description": "需求的迫切程度，请按照“非常迫切 10”到“非常不迫切 0”进行选择"
                }
            ]
        }
    ],
    "showQuestionNumbers": "off",
    "requiredText": "【必填项】"
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
  const SurveyTestPage({Key? key, required this.surveyJson}) : super(key: key);

  final String surveyJson;

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
