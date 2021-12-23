/**
 * Строковые константы.
 * 
 * Struct: `screen/component/widget name` + `Element`
 * 
 * Example
 * ```dart
 *  Text(AppStrings.sightDetailsGetDirections)
 * ```
 */
class AppStrings {
  // SightDetails screen
  static const sightDetailsGetDirections = 'Построить маршрут';
  static const sightDetailsSchedule = 'Запланировать';
  static const sightDetailsAddToWishlist = 'В избранное';

  //  visiting screen
  static const visitingAppBarTitle = 'Избранное';
  static const visitingTabTitles = ['Хочу посетить', 'Посетил'];
  static const visitingEmpty = 'Пусто';
  static const visitingWantToVisitEmpty =
      'Отмечайте понравившиеся места и они появиятся здесь.';
  static const visitingVisitedEmpty =
      'Завершите маршрут, чтобы место попало сюда.';
}
