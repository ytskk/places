import 'package:intl/intl.dart';

class PluralForms {
  const PluralForms({
    required this.zero,
    required this.one,
    required this.few,
    required this.many,
    required this.other,
  });

  final String zero;
  final String one;
  final String few;
  final String many;
  final String other;
}

class PluralWords {
  const PluralWords._();

  static const String place = 'Место';
}

const Map<String, PluralForms> plurals = {
  PluralWords.place: PluralForms(
    zero: 'Мест',
    one: 'Место',
    few: 'Места',
    many: 'Мест',
    other: 'Место',
  ),
};

String pluralize(int howMany, String word) {
  return Intl.plural(
    howMany,
    zero: plurals[word]!.zero,
    one: plurals[word]!.one,
    few: plurals[word]!.few,
    many: plurals[word]!.many,
    other: plurals[word]!.other,
    locale: 'ru',
  );
}
