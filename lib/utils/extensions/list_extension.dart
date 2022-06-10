const tempImageUrl =
    'https://images.assetsdelivery.com/compings_v2/yehorlisnyi/yehorlisnyi2104/yehorlisnyi210400016.jpg';

extension ListExtension on List {
  String get takeFirstImgOrTemp => isEmpty ? tempImageUrl : first;
}
