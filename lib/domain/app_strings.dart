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
  static const sightTitle = "Список интересных мест";
  static const sightFloatingButtonLabel = "новое место";

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

  // add sight screen
  static const addSightScreenAppTitle = "Новое место";
  static const addSightScreenAppLeading = "Отмена";
  static const addSightScreenCategoryTitle = "Категория";
  static const addSightScreenCategoryLabel = "Не выбрано";
  static const addSightScreenSightNameTitle = "название";
  static const addSightScreenSightCoordinatesLat = "широта";
  static const addSightScreenSightCoordinatesLon = "долгота";
  static const addSightScreenSightShowOnMap = "Указать на карте";
  static const addSightScreenSightDescription = "описание";
  static const addSightScreenSightDescriptionHint = "Введите текст";
  static const addSightScreenSightCreate = "создать";
  static const addSightScreenSightSave = "сохранить";
  static const addSightScreenSightDialogCreateContent =
      "Место успешно добавлено!";
  static const addSightScreenSightDialogCloseContent =
      "Уверены что хотите закрыть? Вы потеряете введённые данные.";
  static const addSightScreenSightDialogCloseActionClose = "Да";
  static const addSightScreenSightDialogCloseActionStay = "Нет";

  static const addSightScreenSightDialogCreateActionTitle = "Закрыть";

  // search field
  static const searchFieldHint = "Поиск";
  static const searchScreenNotFoundTitle = "Ничего не найдено.";
  static const searchScreenNotFoundSubtitle =
      "Попробуйте изменить параметры поиска";
  static const searchScreenRecentActivity = "вы искали";
  static const searchScreenRecentActivityRecommendations = "Рекомендации";
  static const searchScreenRecentActivityClear = "Очистить историю";
}
