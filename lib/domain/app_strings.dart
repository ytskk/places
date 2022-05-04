/// Constant strings of the application.
///
/// Struct: `screen/component/widget name` + `Modifier`
///
/// ```
///  Text(AppStrings.sightDetailsGetDirectionsTitle)
/// ```
class AppStrings {
  // Sight Screen
  static const sightTitle = 'Список интересных мест';
  static const sightTitleExpanded = 'Список\nинтересных мест';
  static const sightFloatingButtonLabel = 'новое место';
  static const sightClosedUntil = 'Закрыто до';

  // SightDetails screen
  static const sightDetailsWorkingStatusClosed = 'Закрыто до';
  static const sightDetailsWorkingStatusOpened = 'Открыто до';
  static const sightDetailsGetDirections = 'Построить маршрут';
  static const sightDetailsSchedule = 'Запланировать';
  static const sightDetailsScheduledAt = 'Запланировано на';
  static const sightDetailsAddToWishlist = 'В избранное';
  static const sightDetailsInWishlist = 'В избранном';

  //  visiting screen
  static const visitingAppBarTitle = 'Избранное';
  static const visitingTabTitles = ['Хочу посетить', 'Посетил'];
  static const visitingEmpty = 'Пусто';
  static const visitingWantToVisitEmpty =
      'Отмечайте понравившиеся места и они появиятся здесь.';
  static const visitingVisitedEmpty =
      'Завершите маршрут, чтобы место попало сюда.';
  static const visitingWantToVisitPlannedAt = 'Запланировано на';
  static const visitingWantToVisitClosedUntil = 'Закрыто до';
  static const visitingVisitedAchieved = 'Цель достигнута';
  static const visitingVisitedClosedUntil = 'Закрыто до';
  static const visitingDismissibleText = 'Удалить';

  // filter screen
  static const filterScreenActionClear = 'Очистить';
  static const filterScreenRangeSelectionGroupTitle = 'Расстояние';
  static const filterScreenRangeSelectionGroupTitleAfter = 'от 10 до 30 км';
  static const filterScreenFilterTitle = 'Категории';
  static const filterScreenFilterShow = 'Показать';

  // settings screen
  static const settingsScreenAppTitle = 'Настройки';
  static const settingsScreenDarkThemeTitle = 'Тёмная тема';
  static const settingsScreenTutorialTitle = 'Смотреть туториал';

  // add sight screen
  static const addSightScreenAppTitle = 'Новое место';
  static const addSightScreenAppLeading = 'Отмена';
  static const addSightScreenCategoryTitle = 'Категория';
  static const addSightScreenCategoryLabel = 'Не выбрано';
  static const addSightScreenSightNameTitle = 'название';
  static const addSightScreenSightCoordinatesLat = 'широта';
  static const addSightScreenSightCoordinatesLon = 'долгота';
  static const addSightScreenSightShowOnMap = 'Указать на карте';
  static const addSightScreenSightDescription = 'описание';
  static const addSightScreenSightDescriptionHint = 'Введите текст';
  static const addSightScreenSightCreate = 'создать';
  static const addSightScreenSightSave = 'сохранить';
  static const addSightScreenSightDialogCreateContent =
      'Место успешно добавлено!';
  static const addSightScreenSightDialogCloseContent =
      'Уверены что хотите закрыть? Вы потеряете введённые данные.';
  static const addSightScreenSightDialogCloseActionClose = 'Да';
  static const addSightScreenSightDialogCloseActionStay = 'Нет';
  // image picker options
  static const addSightScreenImagePickerOptionsCameraTitle = 'Камера';
  static const addSightScreenImagePickerOptionsGalleryTitle = 'Фотография';
  static const addSightScreenImagePickerOptionsFileTitle = 'Файл';

  static const addSightScreenSightDialogCreateActionTitle = 'Закрыть';
  static const addSightScreenDeleteImageDialogTitle = 'Удалить фото?';
  static const addSightScreenDeleteImageDialogActionYes = 'Да, удалить';
  static const addSightScreenDeleteImageDialogActionNo = 'Нет, оставить';

  // search field
  static const searchFieldHint = 'Поиск';
  static const searchScreenNotFoundTitle = 'Ничего не найдено.';
  static const searchScreenNotFoundSubtitle =
      'Попробуйте изменить параметры поиска';
  static const searchScreenRecentActivity = 'вы искали';
  static const searchScreenRecentActivityClear = 'Очистить историю';

  // tutor screen
  static const tutorStartButtonTitle = 'На старт';
  static const tutorAppBarSkipButtonText = 'Пропустить';
  static const tutorScreenWelcomeTitle = 'Добро пожаловать в Путеводитель';
  static const tutorScreenWelcomeSubtitle =
      'Ищи новые локации и сохраняй самые любимые.';
  static const tutorScreenBuildDirectionTitle =
      'Построй маршру и отправляйся в путь';
  static const tutorScreenBuildDirectionSubtitle =
      'Достигай цели максимально быстро и комфортно.';
  static const tutorScreenAddPlaceTitle = 'Добавляй места, которые нашёл сам';
  static const tutorScreenAddPlaceSubtitle =
      'Делись самыми интересными и помоги нам стать лучше!';

  // buttons
  static const buttonTextCancel = 'Отмена';
}
