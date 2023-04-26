// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surveyvalidator.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

abstract class SurveyvalidatorBuilder {
  void replace(Surveyvalidator other);
  void update(void Function(SurveyvalidatorBuilder) updates);
  String? get text;
  set text(String? text);

  String? get type;
  set type(String? type);
}

class _$$Surveyvalidator extends $Surveyvalidator {
  @override
  final String? text;
  @override
  final String? type;

  factory _$$Surveyvalidator(
          [void Function($SurveyvalidatorBuilder)? updates]) =>
      (new $SurveyvalidatorBuilder()..update(updates))._build();

  _$$Surveyvalidator._({this.text, this.type}) : super._();

  @override
  $Surveyvalidator rebuild(void Function($SurveyvalidatorBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  $SurveyvalidatorBuilder toBuilder() =>
      new $SurveyvalidatorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is $Surveyvalidator &&
        text == other.text &&
        type == other.type;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, text.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'$Surveyvalidator')
          ..add('text', text)
          ..add('type', type))
        .toString();
  }
}

class $SurveyvalidatorBuilder
    implements
        Builder<$Surveyvalidator, $SurveyvalidatorBuilder>,
        SurveyvalidatorBuilder {
  _$$Surveyvalidator? _$v;

  String? _text;
  String? get text => _$this._text;
  set text(covariant String? text) => _$this._text = text;

  String? _type;
  String? get type => _$this._type;
  set type(covariant String? type) => _$this._type = type;

  $SurveyvalidatorBuilder() {
    $Surveyvalidator._defaults(this);
  }

  $SurveyvalidatorBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _text = $v.text;
      _type = $v.type;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant $Surveyvalidator other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$$Surveyvalidator;
  }

  @override
  void update(void Function($SurveyvalidatorBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  $Surveyvalidator build() => _build();

  _$$Surveyvalidator _build() {
    final _$result = _$v ?? new _$$Surveyvalidator._(text: text, type: type);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
