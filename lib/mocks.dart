import 'models/sight.dart';

final List<Sight> mocks = [
  Sight(
    name: 'Norke Prime Китай-город',
    lat: 55.752337,
    lon: 37.640978,
    url:
        'https://avatars.mds.yandex.net/get-tycoon/6176274/2a0000017eaff3c13673528230d76ce0b2fa/priority-headline-background',
    type: 'Отель',
  ),
  Sight(
    name: 'Отель Москва METROPOL',
    lat: 55.758448,
    lon: 37.621660,
    url:
        'https://avatars.mds.yandex.net/get-altay/223006/2a0000015b0b6ce0ac88ee541f367dc4ea9e/XXXL',
    type: 'Ресторан',
  ),
  Sight(
    name: 'ГУМ',
    lat: 55.754740,
    lon: 37.621408,
    url:
        'https://avatars.mds.yandex.net/get-altay/216588/2a0000015b2e8b5af92a844bc891e2f54aad/L',
    details:
        'Крупный торговый комплекс в центре Москвы, который занимает целый квартал Китай-города и выходит главным фасадом на Красную площадь. Здание, построенное в 1893 году в русском стиле, является памятником архитектуры федерального значения и находится в федеральной собственности.',
    type: 'Особое место',
  ),
  Sight(
    name: 'Дом на набережной',
    lat: 55.744450,
    lon: 37.613072,
    url:
        'https://avatars.mds.yandex.net/get-altay/3966989/2a000001750218b51e5a8d3b47255eb201d2/L',
    details: '',
    type: 'Парк',
  ),
  Sight(
    name: 'Surf Coffee',
    lat: 55.742331,
    lon: 37.610009,
    url:
        'https://avatars.mds.yandex.net/get-altay/923092/2a000001625a4cd076a95a5640a14cea46ca/L',
    details: '',
    type: 'Кафе',
  ),
  Sight(
    name: 'Пётр I - памятник 300-летию Российского флота',
    lat: 55.730831,
    lon: 37.607574,
    url:
        'https://avatars.mds.yandex.net/get-altay/1778671/2a0000016c4cf082ca263bd6369cd2a1031b/L',
    details:
        'Работы Зураба Церетели был воздвигнут в 1997 году по заказу Правительства Москвы на искусственном острове, насыпанном у разделения Москвы-реки и Водоотводного канала. Один из самых высоких памятников в России. Общая высота памятника 98 метров, высота фигуры Петра 18 м.',
    type: 'Музей',
  ),
];

final List filterCategories = [
  SightCategories.hotel,
  SightCategories.restaurant,
  SightCategories.poi,
  SightCategories.park,
  SightCategories.museum,
  SightCategories.cafe,
];
