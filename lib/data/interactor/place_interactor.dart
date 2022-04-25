import 'package:places/data/model/place_model.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/models/coordinates.dart';
import 'package:places/models/places_filter_request_dto.dart';

class PlaceInteractor {
  final PlaceRepository placeRepository;

  /// Repository may depends (network, storage etc.).
  PlaceInteractor({required this.placeRepository});

  //
  Future<List<PlaceDto>> getPlaces({
    required double radius,
    List<String>? types,
  }) async {
    /// Current user coordinates.
    ///
    /// TODO: replace with location request.
    final Coordinates _coordinates = Coordinates(55.754093, 37.620407);

    final List<PlaceDto> places = await placeRepository.getFilteredPlaces(
      filterOptions: PlacesFilterRequestDto(
        radius: radius,
        lat: _coordinates.lat,
        lng: _coordinates.lon,
        typeFilter: types,
      ),
    );

    final sortedPlaces = [...places];
    sortedPlaces.sort((a, b) => a.distance.compareTo(b.distance));

    return sortedPlaces;
    // return placeRepository.getAllPlaces();
  }

  Future getPlaceDetails({required int id}) async {
    return placeRepository.getPlaceById(id: id);
  }
}
