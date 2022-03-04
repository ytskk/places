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
  // Sight Screen
  static const sightTitleList = "Список\n";
  static const sightTitleInterestingPlaces = "Интересных мест";

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

  // filter screen
  static const filterScreenActionClear = "Очистить";
  static const filterScreenRangeSelectionGroupTitle = "Расстояние";
  static const filterScreenRangeSelectionGroupTitleAfter = "От 10м до 10 000м";
  static const filterScreenFilterTitle = "Категории";
  static const filterScreenFilterShow = "Показать";

  // settings screen
  static const settingsScreenAppTitle = "Настройки";
  static const settingsScreenDarkThemeTitle = "Тёмная тема";
  static const settingsScreenTutorialTitle = "Смотреть туториал";
}
